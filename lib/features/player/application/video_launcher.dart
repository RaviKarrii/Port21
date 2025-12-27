import 'dart:io';
import 'package:android_intent_plus/android_intent.dart'; // Fixed import
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:port21/features/player/application/sftp_stream_server.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port21/features/library/application/library_providers.dart'; // For isarProvider
import 'package:isar/isar.dart';
import 'package:port21/features/download/domain/downloaded_media.dart';

class VideoLauncher {
  static Future<void> launch(BuildContext context, WidgetRef ref, String url, String? contentId) async {
    // 1. Show Bottom Sheet to Choose Player
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF151515),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Play Video",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.play_circle_filled, color: Colors.tealAccent, size: 32),
                title: const Text("Internal Player", style: TextStyle(color: Colors.white)),
                subtitle: const Text("Best for most videos", style: TextStyle(color: Colors.grey)),
                onTap: () => Navigator.pop(context, 'internal'),
              ),
              if (Platform.isAndroid)
                ListTile(
                  leading: const Icon(Icons.open_in_new, color: Colors.orangeAccent, size: 32),
                  title: const Text("External Player (VLC, MX Player)", style: TextStyle(color: Colors.white)),
                  subtitle: const Text("Use for casting or unsupported formats", style: TextStyle(color: Colors.grey)),
                  onTap: () => Navigator.pop(context, 'external'),
                ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );

    if (choice == null) return; // User cancelled

    // Smart Local Playback Check
    String finalUrl = url;
    if (contentId != null) {
       try {
         final isar = ref.read(isarProvider);
         final localMedia = await isar.downloadedMedias.filter().contentIdEqualTo(contentId).findFirst();
         
         if (localMedia != null && localMedia.status == 'completed' && await File(localMedia.path).exists()) {
            finalUrl = localMedia.path;
            if (context.mounted) {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(content: Text("Playing from Downloads (Offline)"), backgroundColor: Colors.green, duration: Duration(seconds: 2)),
               );
            }
         }
       } catch (e) {
         print("Error checking local media: $e");
       }
    }

    if (choice == 'internal') {
      if (context.mounted) {
         context.push('/player', extra: {'url': finalUrl, 'contentId': contentId});
      }
    } else if (choice == 'external') {
      _launchExternal(context, finalUrl);
    }
  }

  static Future<void> _launchExternal(BuildContext context, String url) async {
    String playbackUrl = url;
    SftpStreamServer? sftpServer;

    try {
      // 1. Handle SFTP (Start Proxy)
      if (url.startsWith('sftp://')) {
        // Show loading dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => const Center(child: CircularProgressIndicator()),
        );

        try {
            final uri = Uri.parse(url);
            final userInfo = uri.userInfo.split(':');
            final user = userInfo[0];
            final pass = userInfo.sublist(1).join(':'); 
            final path = Uri.decodeComponent(uri.path); 
            
            sftpServer = SftpStreamServer();
            await sftpServer.start(
              uri.host, 
              uri.port == 0 ? 22 : uri.port, 
              user, 
              Uri.decodeComponent(pass),
              path
            );
            playbackUrl = sftpServer.url;
            
             if (context.mounted) Navigator.pop(context); // Close loading
        } catch (e) {
             if (context.mounted) Navigator.pop(context); // Close loading
             if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Proxy Error: $e")));
             }
             return;
        }
      }

      // 2. Launch Intent
      final intent = AndroidIntent(
        action: 'action_view',
        data: playbackUrl,
        type: 'video/*', // Explicitly set video MIME type
        flags: <int>[Flag.FLAG_GRANT_READ_URI_PERMISSION],
      );
      await intent.launch();

      // 3. Show "Streaming Active" Screen if using SFTP
      if (sftpServer != null && context.mounted) {
         await showDialog(
           context: context,
           barrierDismissible: false,
           builder: (context) => AlertDialog(
             backgroundColor: const Color(0xFF151515),
             title: const Text("Streaming to External Player", style: TextStyle(color: Colors.white)),
             content: const Text(
               "Keep this screen open while watching.\nClosing this will stop the playback stream.",
               style: TextStyle(color: Colors.grey),
             ),
             actions: [
               TextButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text("STOP PLAYBACK", style: TextStyle(color: Colors.redAccent)),
               ),
             ],
           ),
         );
         
         // Cleanup after dialog closes
         await sftpServer.stop();
      }

    } catch (e) {
      if (context.mounted) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Launch Error: $e")));
      }
      sftpServer?.stop();
    }
  }
}
