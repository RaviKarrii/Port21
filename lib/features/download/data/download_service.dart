import 'dart:async';
import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:port21/features/library/application/file_verification_service.dart';
import 'package:port21/features/settings/data/settings_repository.dart';
import 'package:flutter_downloader/flutter_downloader.dart'; // Added for clearAllDownloads

// --- Enums and Models ---

enum DownloadTaskStatus {
  undefined,
  enqueued,
  running,
  complete,
  failed,
  canceled,
  paused
}

class DownloadEvent {
  final String id;
  final String title;
  final int progress;
  final DownloadTaskStatus status;
  final String filename;
  final String savedDir;

  DownloadEvent({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
    required this.filename,
    required this.savedDir,
  });
}

// --- Provider ---

final downloadServiceProvider = Provider((ref) => DownloadService(ref));

class DownloadService {
  final Ref _ref;
  final StreamController<DownloadEvent> _downloadStreamController = StreamController.broadcast();

  DownloadService(this._ref);

  Stream<DownloadEvent> get downloadStream => _downloadStreamController.stream;

  Future<void> downloadFile(String downloadUrl, String title) async {
    // Request Notification Permission for Android 13+
    await Permission.notification.request();

    final settings = _ref.read(settingsRepositoryProvider).getSettings();
    final protocol = settings.streamProtocol;
    
    // Get Local Directory
    String? localDir;
    try {
        final directory = await getExternalStorageDirectory();
        localDir = directory?.path;
    } catch (e) {
        print("Error getting external storage directory: $e");
    }
    
    if (localDir == null) {
       // Fallback
       final dir = await getApplicationDocumentsDirectory();
       localDir = dir.path;
    }


    // 3. Dispatch based on protocol
    if (protocol == 'sftp') {
       await _downloadSftp(downloadUrl, localDir, title, settings);
    } else {
       // Placeholder for non-SFTP (e.g. standard HTTP or FTP if impl)
       print("Protocol $protocol not fully supported for download yet, trying SFTP logic if sftp://");
       if (downloadUrl.startsWith('sftp://')) {
          await _downloadSftp(downloadUrl, localDir, title, settings);
       }
    }
  }

  Future<void> _downloadSftp(String url, String saveDir, String title, dynamic settings) async {
      final String taskId = DateTime.now().millisecondsSinceEpoch.toString();
      
      _downloadStreamController.add(DownloadEvent(
        id: taskId,
        title: title,
        progress: 0,
        status: DownloadTaskStatus.enqueued,
        filename: '$title.mkv',
        savedDir: saveDir,
      ));

      final host = settings.ftpHost;
      final port = settings.ftpPort;
      final user = settings.ftpUser;
      final pass = settings.ftpPassword;
      
      SSHClient? client;
      SftpFile? remoteFile;
      IOSink? sink;

      try {
        _downloadStreamController.add(DownloadEvent(
            id: taskId,
            title: title,
            progress: 0,
            status: DownloadTaskStatus.running,
            filename: '$title.mkv',
            savedDir: saveDir,
         ));

        // 1. Resolve Path
         final resolvedUrl = await _ref.read(fileVerificationServiceProvider).verifyFileExists(
            url: url,
            host: host,
            port: port,
            username: user,
            password: pass,
            isSftp: true,
         );
         
         if (resolvedUrl == null) {
            throw Exception("File not found on server.");
         }
         
         final uri = Uri.parse(resolvedUrl);
         final path = Uri.decodeComponent(uri.path);

         // 2. Connect & Download
         final socket = await SSHSocket.connect(host, port, timeout: const Duration(seconds: 20)); // Increased Timeout
         client = SSHClient(
            socket,
            username: user,
            onPasswordRequest: () => pass,
         );
         await client.authenticated.timeout(const Duration(seconds: 20));
         final sftp = await client.sftp().timeout(const Duration(seconds: 20));
         
         // Retry Logic for Opening File (Absolute vs Relative)
         try {
             remoteFile = await sftp.open(path, mode: SftpFileOpenMode.read);
         } catch (e) {
             print("SFTP Open '$path' failed: $e");
             if (path.startsWith('/')) {
                 final relPath = path.substring(1);
                 print("Retrying with relative path: '$relPath'");
                 remoteFile = await sftp.open(relPath, mode: SftpFileOpenMode.read);
             } else {
                 rethrow;
             }
         }
         
         final fileSize = (await remoteFile!.stat())?.size ?? 0;
         
         final localFile = File('$saveDir/$title.mkv');
         sink = localFile.openWrite();
         
         final int chunkSize = 1024 * 1024; // 1 MB
         int offset = 0;
         
         while (offset < fileSize) {
            // Check if cancelled? (Not impl yet, simpler logic)
            final chunk = await remoteFile!.readBytes(length: chunkSize, offset: offset);
            if (chunk.isEmpty) break;
            
            sink.add(chunk);
            offset += chunk.length;
            
            if (fileSize > 0) {
              final int progress = ((offset / fileSize) * 100).toInt();
              // Update UI every 5% or so? No, stream is fine.
              _downloadStreamController.add(DownloadEvent(
                id: taskId,
                title: title,
                progress: progress,
                status: DownloadTaskStatus.running,
                filename: '$title.mkv',
                savedDir: saveDir,
              ));
            }
         }
         
         await sink.flush();
         
         // Success
         _downloadStreamController.add(DownloadEvent(
            id: taskId,
            title: title,
            progress: 100,
            status: DownloadTaskStatus.complete,
            filename: '$title.mkv',
            savedDir: saveDir,
         ));
         
      } catch (e) {
          print("SFTP Download Failed: $e");
          _downloadStreamController.add(DownloadEvent(
            id: taskId,
            title: title,
            progress: 0,
            status: DownloadTaskStatus.failed,
            filename: '$title.mkv',
            savedDir: saveDir,
         ));
          // Show error
          // rethrow; // Consumed by the stream listener usually, or we can silence it here to prevent crash
      } finally {
          try { await sink?.close(); } catch (_) {}
          try { await remoteFile?.close(); } catch (_) {}
          client?.close();
      }
  }

  Future<void> clearAllDownloads() async {
      // Clear Flutter Downloader Tasks
      await FlutterDownloader.cancelAll();
      final tasks = await FlutterDownloader.loadTasks();
      if (tasks != null) {
          for (var t in tasks) {
             // Remove from DB and delete file
             await FlutterDownloader.remove(taskId: t.taskId, shouldDeleteContent: true);
          }
      }
  }
}
