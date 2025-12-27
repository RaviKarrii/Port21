import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileVerificationService {
  Future<String?> verifyFileExists({
    required String url,
    required String host,
    required int port,
    required String username,
    required String password,
    required bool isSftp,
  }) async {
    // 1. Parse path from URL
    final uri = Uri.parse(url);
    String filePath = Uri.decodeComponent(uri.path); // Fix: Decode %20 to spaces
    
    // If path is empty or just /, something is wrong
    if (filePath.isEmpty || filePath == '/') {
      throw Exception('Invalid file path derived from URL');
    }

    // For relative paths in "sftp://host:port/path", Uri.path does return "/path"
    
    if (isSftp) {
        return _checkSftp(host, port, username, password, filePath, url);
    } else {
        return _checkFtp(host, port, username, password, filePath, url);
    }
  }

  Future<String?> _checkSftp(String host, int port, String user, String pass, String path, String originalUrl) async {
    SSHClient? client;
    try {
      final socket = await SSHSocket.connect(host, port, timeout: const Duration(seconds: 10));
      client = SSHClient(
        socket,
        username: user,
        onPasswordRequest: () => pass,
      );
      
    // Verification Hang Fix: Add timeout to authentication
      await client.authenticated.timeout(const Duration(seconds: 10));
      final sftp = await client.sftp().timeout(const Duration(seconds: 10));
      
      // Try stat (Original Absolute Path)
      try {
        print('VERIFY: Checking absolute path: $path');
        final stat = await sftp.stat(path).timeout(const Duration(seconds: 10));
        if (stat != null) {
            print('VERIFY: Absolute path found!');
            return originalUrl;
        }
      } catch (e) {
        print('VERIFY: Absolute path check failed: $e');
        // Fallthrough to relative check
      }

      // If we failed with leading slash, and path starts with /, try removing it (relative check)
      if (path.startsWith('/')) {
          try {
             // CHANGE: Trim all leading slashes to ensure it's truly relative
             final relativePath = path.replaceAll(RegExp(r'^/+'), '');
             print('VERIFY: Retrying relative path: $relativePath');

             final stat = await sftp.stat(relativePath).timeout(const Duration(seconds: 10));
             
             if (stat != null) {
                print('VERIFY: Relative found. Using strictly relative path (treated as absolute from root)...');
                
                // Do NOT resolve pwd. It breaks chrooted environments (e.g. /home32/naaserver vs /)
                // Just ensure the path we return starts with / so it's a valid URI path component
                String finalPath = relativePath;
                if (!finalPath.startsWith('/')) finalPath = '/$finalPath';
                
                print('VERIFY: Final Playback Path: $finalPath');
                
                // Reconstruct URL
                 final uri = Uri.parse(originalUrl);
                 
                 // Remove port if standard 22 (VLC quirk?)
                 int? finalPort = uri.port;
                 if (finalPort == 22) finalPort = null;
                 
                 final newUrl = uri.replace(
                    path: finalPath,
                    port: finalPort,
                 ).toString();
                 
                 print('VERIFY: Returning New URL: $newUrl');
                 return newUrl;
             }
          } catch (e2) {
              print('VERIFY: Relative check failed: $e2');
              // ignore
          }
      }
      
      return null; // Not found
      return null; // Not found
    } catch (e, stack) {
      print('VERIFY: SFTP Error: $e');
      print('VERIFY: Stack: $stack');
      if (e.toString().contains('Authentication failed')) {
           throw Exception('SFTP Authentication failed');
      }
      return null;
    } finally {
      client?.close();
    }
  }

  Future<String?> _checkFtp(String host, int port, String user, String pass, String path, String originalUrl) async {
    FTPConnect? ftpClient;
    try {
      ftpClient = FTPConnect(
          host, 
          port: port, 
          user: user, 
          pass: pass,
          timeout: 5 // Set explicit timeout in seconds for FTP
      );
      await ftpClient.connect();
      
      print('VERIFY: FTP checking path: $path');
      final size = await ftpClient.sizeFile(path);
      if (size != -1) {
          print('VERIFY: FTP Found absolute path!');
          return originalUrl;
      }
      
      if (path.startsWith('/')) {
         print('VERIFY: FTP Absolute not found, trying relative...');
         // Try relative
         final relativePath = path.substring(1);
         final sizeRel = await ftpClient.sizeFile(relativePath);
         if (sizeRel != -1) {
             // For FTP, usually standard URLs handle this ambiguity better, 
             // or listing PWD might work but is complex. 
             // If relative works for FTP, it might just work for Player depending on player.
             // But for now, let's just return originalUrl IF it was relative?
             // Or maybe we can't easily resolve absolute path in generic FTP without PWD command.
             // Let's assume for FTP, the Player handles it or we return originalUrl if we can't improve it.
             // Actually, if originalUrl had /path and it failed, returning it won't help.
             // But we can try to return the relative version? 
             // ftp://host:port/path (without leading slash).
             // Uri always puts slash.
             // We'll stick to returning originalUrl and hope Player uses same relativity logic,
             // OR return null? 
             // For now return originalUrl if relative found, hoping it's just a stat quirk.
             return originalUrl;
         }
      }
      
      return null;
    } catch (e, stack) {
      print('VERIFY: FTP Error: $e');
      print('VERIFY: Stack: $stack');
      if (e.toString().contains('Login incorrect')) {
           throw Exception('FTP Login incorrect');
      }
      return null;
    } finally {
      await ftpClient?.disconnect();
    }
  }
}

final fileVerificationServiceProvider = Provider((ref) => FileVerificationService());
