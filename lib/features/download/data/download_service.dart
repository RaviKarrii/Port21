import 'dart:async';
import 'dart:io';

import 'package:dartssh2/dartssh2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:port21/features/library/application/file_verification_service.dart';
import 'package:port21/features/settings/data/settings_repository.dart';
import 'package:flutter_downloader/flutter_downloader.dart'; // Added for clearAllDownloads
import 'package:isar/isar.dart';
import 'package:port21/features/library/application/library_providers.dart'; // For isarProvider
import 'package:port21/features/download/domain/downloaded_media.dart';

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
  final String contentId; // Added
  final String savedDir;

  DownloadEvent({
    required this.id,
    required this.title,
    required this.progress,
    required this.status,
    required this.filename,
    required this.contentId, // Added
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

  Future<void> downloadFile(String downloadUrl, String title, String contentId) async {
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
       await _downloadSftp(downloadUrl, localDir, title, contentId, settings);
    } else {
       // Placeholder for non-SFTP (e.g. standard HTTP or FTP if impl)
       print("Protocol $protocol not fully supported for download yet, trying SFTP logic if sftp://");
       if (downloadUrl.startsWith('sftp://')) {
          await _downloadSftp(downloadUrl, localDir, title, contentId, settings);
       }
    }
  }

  Future<void> _downloadSftp(String url, String saveDir, String title, String contentId, dynamic settings) async {
      // Use Nano-second precision + random component for unique IDs in tight loops
      final String taskId = '${DateTime.now().microsecondsSinceEpoch}_${(1000 + (DateTime.now().millisecond % 1000))}';
      
      _downloadStreamController.add(DownloadEvent(
        id: taskId,
        title: title,
        progress: 0,
        status: DownloadTaskStatus.enqueued,
        filename: '$title.mkv',
        savedDir: saveDir,
        contentId: contentId,
      ));

      // NEW: Persist to Isar (Optimistic)
      final isar = _ref.read(isarProvider);
      
      // We need a contentId. For now, we will assume title is unique enough or pass it in. 
      // Ideally, the signature of downloadFile should change.
      // But to avoid breaking changes immediately, let's try to derive or update signature.
      // Wait, the plan says "Update downloadFile(url, title, contentId)".
      // I need to update the signature first.


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
            contentId: contentId,
         ));

         // PERSIST INITIAL STATE
         final isar = _ref.read(isarProvider);
         await isar.writeTxn(() async {
            final existing = await isar.downloadedMedias.filter().contentIdEqualTo(contentId).findFirst();
             if (existing != null) {
                existing.status = 'downloading';
                existing.path = '$saveDir/$title.mkv';
                existing.streamUrl = url;
                await isar.downloadedMedias.put(existing);
             } else {
                final newItem = DownloadedMedia()
                  ..contentId = contentId
                  ..title = title
                  ..path = '$saveDir/$title.mkv'
                  ..streamUrl = url
                  ..status = 'downloading'
                  ..downloadedAt = DateTime.now();
                await isar.downloadedMedias.put(newItem);
             }
         });

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
            // Check if cancelled?
            if (_cancellationTokens.containsKey(taskId)) {
                _cancellationTokens.remove(taskId);
                await sink.close();
                await localFile.delete();
                _downloadStreamController.add(DownloadEvent(
                   id: taskId,
                   title: title,
                   progress: 0,
                   status: DownloadTaskStatus.canceled,
                   filename: '$title.mkv',
                   savedDir: saveDir,
                   contentId: contentId,
                ));
                return;
            }

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
                contentId: contentId,
              ));
            }
         }
         
         await sink.flush();
         
         // Success
         // Success
         _downloadStreamController.add(DownloadEvent(
            id: taskId,
            title: title,
            progress: 100,
            status: DownloadTaskStatus.complete,
            filename: '$title.mkv',
            savedDir: saveDir,
            contentId: contentId,
         ));
         
         // Update Isar to Completed
         // Reuse 'isar' from top of function
         await isar.writeTxn(() async {
            // Find existing or create new
            final existing = await isar.downloadedMedias.filter().contentIdEqualTo(contentId).findFirst();
            if (existing != null) {
               existing.status = 'completed';
               existing.path = '$saveDir/$title.mkv';
               existing.downloadedAt = DateTime.now();
               await isar.downloadedMedias.put(existing);
            } else {
               final newItem = DownloadedMedia()
                 ..contentId = contentId
                 ..title = title
                 ..path = '$saveDir/$title.mkv'
                 ..streamUrl = url
                 ..status = 'completed'
                 ..downloadedAt = DateTime.now();
               await isar.downloadedMedias.put(newItem);
            }
         });
         
      } catch (e) {
          print("SFTP Download Failed: $e");
          _downloadStreamController.add(DownloadEvent(
            id: taskId,
            title: title,
            progress: 0,
            status: DownloadTaskStatus.failed,
            filename: '$title.mkv',
            savedDir: saveDir,
            contentId: contentId,
         ));
          // Show error
          // rethrow; // Consumed by the stream listener usually, or we can silence it here to prevent crash
      } finally {
          try { await sink?.close(); } catch (_) {}
          try { await remoteFile?.close(); } catch (_) {}
          client?.close();
      }
  }

  final Map<String, bool> _cancellationTokens = {};

  Future<void> cancelTask(String taskId) async {
      _cancellationTokens[taskId] = true;
      // Also cancel FlutterDownloader if using it
      await FlutterDownloader.cancel(taskId: taskId);
      
      _downloadStreamController.add(DownloadEvent(
        id: taskId,
        title: "Cancelled", 
        progress: 0, 
        status: DownloadTaskStatus.canceled, 
        filename: '', savedDir: '',
        contentId: '',
      ));
  }
  
  Future<void> deleteDownload(String contentId) async {
       final isar = _ref.read(isarProvider);
       await isar.writeTxn(() async {
          final item = await isar.downloadedMedias.filter().contentIdEqualTo(contentId).findFirst();
          if (item != null) {
             final file = File(item.path);
             if (await file.exists()) {
               try {
                 await file.delete();
               } catch (e) {
                 print("Error deleting file: $e");
               }
             }
             await isar.downloadedMedias.delete(item.id);
          }
       });
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
      
      // Clear Isar
      final isar = _ref.read(isarProvider);
      await isar.writeTxn(() async {
          final all = await isar.downloadedMedias.where().findAll();
          for (var item in all) {
              final file = File(item.path);
              if (await file.exists()) {
                   try { await file.delete(); } catch (_) {}
              }
          }
          await isar.downloadedMedias.clear();
      });
  }

  Future<void> init() async {
      final isar = _ref.read(isarProvider);
      await isar.writeTxn(() async {
          // 1. Cleanup Partial ('downloading')
          final partials = await isar.downloadedMedias.filter().statusEqualTo('downloading').findAll();
          for (var p in partials) {
              final file = File(p.path);
              if (await file.exists()) {
                  try { await file.delete(); } catch (_) {}
              }
              await isar.downloadedMedias.delete(p.id);
          }

          // 2. Validate Completed (Remove if file missing)
          final completed = await isar.downloadedMedias.filter().statusEqualTo('completed').findAll();
          for (var c in completed) {
              final file = File(c.path);
              if (!await file.exists()) {
                  await isar.downloadedMedias.delete(c.id);
              }
          }
      });
  }
}
