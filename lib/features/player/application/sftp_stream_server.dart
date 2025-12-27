import 'dart:async';
import 'dart:io';
import 'package:dartssh2/dartssh2.dart';
import 'package:flutter/foundation.dart'; // For debugPrint

import 'package:network_info_plus/network_info_plus.dart';

class SftpStreamServer {
  HttpServer? _server;
  SSHClient? _client;
  SftpClient? _sftp;
  String? _url;
  
  String get url => _url ?? '';

  Future<String> getLanUrl() async {
     if (_server == null) return '';
     final info = NetworkInfo();
     final ip = await info.getWifiIP();
     if (ip == null) return url; // Fallback to what we have (likely 0.0.0.0 which isn't useful for others)
     return 'http://$ip:${_server!.port}/stream';
  }

  Future<void> start(String host, int port, String user, String pass, String path) async {
    // 1. Connect SFTP immediately (Pre-warm)
    debugPrint('STREAM: Pre-connecting SSH...');
    try {
      final socket = await SSHSocket.connect(host, port, timeout: const Duration(seconds: 10));
      _client = SSHClient(
        socket,
        username: user,
        onPasswordRequest: () => pass,
      );
      await _client!.authenticated;
      debugPrint('STREAM: SSH Authenticated. Opening SFTP Channel...');
      _sftp = await _client!.sftp();
      debugPrint('STREAM: SFTP Channel Ready!');
    } catch (e) {
      debugPrint('STREAM: Pre-connect failed: $e');
      rethrow; 
    }

    // 2. Start HTTP Server on 0.0.0.0
    _server = await HttpServer.bind(InternetAddress.anyIPv4, 0);
    _url = 'http://127.0.0.1:${_server!.port}/stream'; // internal use
    debugPrint('STREAM: Server started. Internal: $_url');

    // 3. Handle Requests
    _server!.listen((HttpRequest request) async {
       // debugPrint('STREAM: Request ${request.method} ${request.uri}'); // Reduce noise
       
       SftpFile? file;
       
       try {
         // Re-check client & SFTP
         if (_client == null || _client!.isClosed) {
            debugPrint('STREAM: Re-connecting SSH/SFTP...');
            final socket = await SSHSocket.connect(host, port, timeout: const Duration(seconds: 10));
            _client = SSHClient(
              socket,
              username: user,
              onPasswordRequest: () => pass,
            );
            await _client!.authenticated;
            _sftp = await _client!.sftp();
         }
         
         // Ensure SFTP is ready even if client was open
         if (_sftp == null) {
            _sftp = await _client!.sftp(); 
         }
         
         final sftp = _sftp!;
         
         String? activePath;
         
         // Strategy 1: Absolute Path
         try {
            file = await sftp.open(path, mode: SftpFileOpenMode.read);
            activePath = path;
         } catch (e) {
            debugPrint("STREAM: Failed Exact Path '$path': $e");
            
            // Strategy 1.5: Quick Relative (Strip leading slash)
            // This matches exactly what FileVerificationService does when it finds a "Relative" path.
            if (path.startsWith('/')) {
                final quickRel = path.replaceAll(RegExp(r'^/+'), '');
                try {
                   debugPrint("STREAM: Quick Relative Check '$quickRel'...");
                   file = await sftp.open(quickRel, mode: SftpFileOpenMode.read);
                   activePath = quickRel;
                } catch (eRel) {
                   debugPrint("STREAM: Quick Relative Failed: $eRel");
                }
            }
            
            if (file == null) {
              // Strategy 2: PWD-Relative (Original Slower Method)
            try {
               final pwdResult = await _client!.run('pwd');
               String pwd = String.fromCharCodes(pwdResult).trim();
               debugPrint("STREAM: PWD is '$pwd'");
               
               if (path.startsWith(pwd)) {
                  String relPath = path.substring(pwd.length);
                  if (relPath.startsWith('/')) relPath = relPath.substring(1);
                  
                  try {
                     debugPrint("STREAM: Retrying PWD-Relative Path '$relPath'...");
                     file = await sftp.open(relPath, mode: SftpFileOpenMode.read);
                     activePath = relPath;
                  } catch (e3) {
                     debugPrint("STREAM: Failed PWD-Relative Path: $e3");
                  }
               }
            } catch (e2) {
               debugPrint("STREAM: Failed PWD-Relative: $e2");
            }
            
            }
            
            // Strategy 3: 'media/' Fallback (Handle /home vs /home32 mismatch)
            if (file == null && path.contains('/media/')) {
               try {
                  final mediaIndex = path.indexOf('media/');
                  final mediaPath = path.substring(mediaIndex);
                  debugPrint("STREAM: Retrying 'media/' Strategy: '$mediaPath'...");
                  file = await sftp.open(mediaPath, mode: SftpFileOpenMode.read);
                  activePath = mediaPath;
               } catch (e4) {
                  debugPrint("STREAM: Failed Media Path: $e4");
               }
            }
         }
         
         // Strategy 3: Fuzzy / Directory Listing
         if (file == null) {
            try {
               // Guess parent dir
               String parentDir = path.substring(0, path.lastIndexOf('/'));
               String fileName = path.substring(path.lastIndexOf('/') + 1);
               if (parentDir.isEmpty) parentDir = ".";
               
               // If parentDir is absolute, but we need relative?
               // Let's assume parentDir is absolute first.
               debugPrint("STREAM: Listing '$parentDir' for '$fileName'...");
               
               List<SftpName> items = [];
               try {
                  items = await sftp.listdir(parentDir);
               } catch (e) {
                   debugPrint("STREAM: Failed listing absolute parent: $e");
                   // Try relative parent?
                   // If path was /home/user/media/movie.mp4
                   // Pwd is /home/user
                   // Try media/movie.mp4 -> list media/
               }
               
               
               // If items empty, maybe list "."?
               if (items.isEmpty) {
                   debugPrint("STREAM: Listing Current Directory '.' for debugging...");
                   try {
                      final rootItems = await sftp.listdir('.');
                      debugPrint("STREAM: PWD Contents (${rootItems.length}):");
                      for(var i in rootItems) debugPrint(" - ${i.filename}");
                      
                      request.response.headers.add("X-Debug-PWD-List", rootItems.take(10).map((e)=>e.filename).join(','));
                      
                      // Check if 'media' is here?
                      // If we find 'Media' vs 'media', we can fix it?
                   } catch (e) {
                      debugPrint("STREAM: Failed listing PWD: $e");
                   }
               }
               
               // Scan items
               if (items.isNotEmpty) {
                   debugPrint("STREAM: Found ${items.length} items.");
                   SftpName? match;
                   for (final item in items) {
                       if (item.filename == fileName) {
                           match = item;
                           break; 
                       }
                       if (item.filename.trim().toLowerCase() == fileName.trim().toLowerCase()) {
                           match = item;
                       }
                   }
                   
                   if (match != null) {
                       final correctPath = "$parentDir/${match.filename}";
                       debugPrint("STREAM: Opening Fuzzy Path: '$correctPath'");
                       file = await sftp.open(correctPath, mode: SftpFileOpenMode.read);
                       activePath = correctPath;
                   } else {
                        // Debug Dump
                        request.response.headers.add("X-Debug-Dir", parentDir);
                        request.response.headers.add("X-Debug-Files", items.take(5).map((e)=>e.filename).join(','));
                   }
               }
               
            } catch (e) {
                debugPrint("STREAM: Fuzzy Failed: $e");
            }
         }
         
         if (file == null) {
            throw Exception("File not found. Tried strategies.");
         }
         
         final stat = await sftp.stat(activePath!);
         final fileSize = stat.size ?? 0;
         
         // Range
         int start = 0;
         int end = fileSize - 1;
         int contentLength = fileSize;
         bool isRange = false;
         
         final rangeHeader = request.headers.value(HttpHeaders.rangeHeader);
         if (rangeHeader != null && rangeHeader.startsWith('bytes=')) {
            final parts = rangeHeader.split('=')[1].split('-');
            start = int.tryParse(parts[0]) ?? 0;
            if (parts.length > 1 && parts[1].isNotEmpty) {
               end = int.tryParse(parts[1]) ?? (fileSize - 1);
            }
            // Fix end if invalid
            if (end < start) end = fileSize - 1; 

            contentLength = end - start + 1;
            isRange = true;
         }
         
          final ext = activePath!.toLowerCase();
          String mime = "application/octet-stream";
          if (ext.endsWith(".mp4")) mime = "video/mp4";
          else if (ext.endsWith(".mkv")) mime = "video/x-matroska";
          else if (ext.endsWith(".avi")) mime = "video/x-msvideo";
          
          request.response.headers.contentType = ContentType.parse(mime);
          request.response.headers.add(HttpHeaders.acceptRangesHeader, "bytes");
         
         if (isRange) {
           request.response.statusCode = HttpStatus.partialContent;
           request.response.headers.add(HttpHeaders.contentRangeHeader, "bytes $start-$end/$fileSize");
         } else {
           request.response.statusCode = HttpStatus.ok;
         }
         request.response.contentLength = contentLength;
         
         debugPrint('STREAM: Serve $start-$end ($contentLength bytes)');
         await request.response.addStream(_createStream(file, start, contentLength));
          await request.response.close();
          
        } catch (e) {
          debugPrint('STREAM ERROR: $e');
          try { 
            request.response.statusCode = HttpStatus.internalServerError; 
            request.response.write(e.toString());
            await request.response.close(); 
          } catch (_) {}
        } finally {
           // Important: Close file handle to prevent exhaustion during scrubbing
           try { 
             await file?.close(); 
             debugPrint('STREAM: File closed.'); 
           } catch (_) {}
        }
    });
  }
  
  Stream<List<int>> _createStream(SftpFile file, int start, int length) async* {
    const int chunkSize = 2 * 1024 * 1024; // 2 MB Chunks for better parallelism
    const int lookAhead = 3; // Keep 3 chunks in flight (Total ~6MB in flight)
    
    int bytesYielded = 0;
    int currentReadOffset = start;
    
    // queue of in-flight chunks
    final List<Future<Uint8List>> chunkQueue = [];

    // Helper to request a chunk
    Future<Uint8List> requestChunk(int offset, int totalLength) async {
       final remaining = totalLength - (offset - start); // logic check: offset grows from start
       if (remaining <= 0) return Uint8List(0);
       
       final toRead = remaining > chunkSize ? chunkSize : remaining;
       try {
         // debugPrint("STREAM: Req $offset ($toRead)");
         return await file.readBytes(length: toRead, offset: offset);
       } catch (e) {
         debugPrint("STREAM: Read Error at $offset: $e");
         return Uint8List(0);
       }
    }

    // 1. Prime the pump: Request first 'lookAhead' chunks
    for (int i = 0; i < lookAhead; i++) {
        if (currentReadOffset < start + length) {
            chunkQueue.add(requestChunk(currentReadOffset, length));
            currentReadOffset += chunkSize;
        }
    }

    // 2. Consume and Refill
    try {
      while (bytesYielded < length) {
        if (chunkQueue.isEmpty) break;

        // Await the head of the line (in order)
        final chunk = await chunkQueue.removeAt(0);
        
        if (chunk.isEmpty) break; // Error or EOF
        
        yield chunk;
        bytesYielded += chunk.length;

        // Trigger next fetch if there is more data
        // Check if we haven't already requested past the end
        // currentReadOffset is where the *next* request would start
        if (currentReadOffset < start + length) {
           chunkQueue.add(requestChunk(currentReadOffset, length));
           currentReadOffset += chunkSize;
        }
      }
    } catch (e) {
       debugPrint("STREAM: Generator Error: $e");
    }
  }

  Future<void> stop() async {
    await _server?.close(force: true);
    _client?.close();
    _server = null;
    _client = null;
  }
}
