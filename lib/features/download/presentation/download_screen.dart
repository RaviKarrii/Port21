import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:go_router/go_router.dart';
import '../../player/presentation/player_screen.dart';
import '../data/download_service.dart' as svc;

class DownloadScreen extends ConsumerStatefulWidget {
  const DownloadScreen({super.key});

  @override
  ConsumerState<DownloadScreen> createState() => _DownloadScreenState();
}

class UiDownloadTask {
  final String taskId;
  final String filename;
  final int progress;
  final DownloadTaskStatus status;
  final String savedDir;
  
  UiDownloadTask({
    required this.taskId,
    required this.filename,
    required this.progress,
    required this.status,
    required this.savedDir,
  });
}

class _DownloadScreenState extends ConsumerState<DownloadScreen> {
  // Merged list of tasks
  List<UiDownloadTask> uiTasks = [];
  
  // Separate sources
  List<DownloadTask>? flutterTasks;
  final Map<String, svc.DownloadEvent> sftpTasks = {}; 
  
  final ReceivePort _port = ReceivePort();
  StreamSubscription<svc.DownloadEvent>? _streamSubscription;

  @override
  void initState() {
    super.initState();
    _bindBackgroundIsolate();
    FlutterDownloader.registerCallback(downloadCallback);
    
    // Load initial Flutter tasks
    _loadTasks();
    
    // Listen to manual SFTP events
    _streamSubscription = ref.read(svc.downloadServiceProvider).downloadStream.listen((event) {
       setState(() {
         sftpTasks[event.id] = event;
         _mergeTasks();
       });
    });
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _mergeTasks() {
      // Clear current UI list
      uiTasks.clear();
      
      // 1. Add SFTP Tasks (Manual)
      final sftpList = sftpTasks.values.map((e) => UiDownloadTask(
         taskId: e.id,
         filename: e.filename ?? e.title,
         progress: e.progress,
         status: _mapSftpStatus(e.status),
         savedDir: e.savedDir,
      )).toList();
      
      // 2. Add FlutterDownloader Tasks
      if (flutterTasks != null) {
        final fList = flutterTasks!.map((t) => UiDownloadTask(
           taskId: t.taskId,
           filename: t.filename ?? "Unknown",
           progress: t.progress,
           status: t.status,
           savedDir: t.savedDir,
        )).toList();
        
        uiTasks = [...sftpList, ...fList];
      } else {
        uiTasks = sftpList;
      }
      
      // Sort by recent? Or status?
      // uiTasks.sort...
  }

  void _loadTasks() async {
    final t = await FlutterDownloader.loadTasks();
    setState(() {
      flutterTasks = t;
      _mergeTasks();
    });
  }

  void _bindBackgroundIsolate() {
    final isSuccess = IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      // String id = data[0];
      // int status = data[1];
      // int progress = data[2];
      setState(() {
        _loadTasks(); 
      });
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Downloads"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever_sharp),
            onPressed: () async {
               final confirmed = await showDialog<bool>(
                 context: context,
                 builder: (context) => AlertDialog(
                   title: const Text("Clear All?"),
                   content: const Text("This will remove all download records. Files might persist."),
                   actions: [
                     TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("CANCEL")),
                     TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("CLEAR")),
                   ],
                 ),
               );
               
               if (confirmed == true) {
                 await ref.read(svc.downloadServiceProvider).clearAllDownloads();
                 setState(() {
                    sftpTasks.clear(); // Clear manual map too
                    _loadTasks();
                 });
                 if (mounted) {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Downloads Cleared")));
                 }
               }
            },
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          if (uiTasks.isEmpty && flutterTasks == null) {
             // Loading state if flutter tasks not loaded
             return const Center(child: CircularProgressIndicator());
          }
          if (uiTasks.isEmpty) {
            return const Center(child: Text("No downloads"));
          }
          return ListView.builder(
            itemCount: uiTasks.length,
            itemBuilder: (context, index) {
              final task = uiTasks[index];
              final progress = task.progress / 100.0;
              final status = task.status;

              return Container(
                margin: const EdgeInsets.only(bottom: 0),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF495057), width: 0.5),
                  color: const Color(0xFF151515),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    task.filename, 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          status.toString().split('.').last.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10, 
                            color: _getStatusColor(status), 
                            letterSpacing: 1.0, 
                            fontWeight: FontWeight.w900
                          ),
                        ),
                        const SizedBox(width: 12),
                        if (status == DownloadTaskStatus.running)
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress, 
                              minHeight: 4, 
                              color: const Color(0xFFEEEEEE), 
                              backgroundColor: const Color(0xFF282C34),
                            ),
                          )
                        else 
                          const SizedBox(),
                      ],
                    ),
                  ),
                  trailing: status == DownloadTaskStatus.complete
                      ? IconButton(
                          icon: const Icon(Icons.play_arrow_sharp),
                          onPressed: () {
                            final path = '${task.savedDir}/${task.filename}';
                            context.push('/player', extra: path);
                          },
                          color: Colors.white,
                        )
                      : status == DownloadTaskStatus.failed
                         ? const Icon(Icons.error_outline_sharp, color: Colors.red)
                         : Text(
                             '${(progress * 100).toInt()}%',
                             style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.bold, color: Colors.grey),
                           ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _getStatusColor(DownloadTaskStatus status) {
    if (status == DownloadTaskStatus.running) return Colors.blueAccent;
    if (status == DownloadTaskStatus.complete) return Colors.greenAccent;
    if (status == DownloadTaskStatus.failed) return Colors.redAccent;
    return Colors.grey;
  }

  DownloadTaskStatus _mapSftpStatus(svc.DownloadTaskStatus status) {
      if (status == svc.DownloadTaskStatus.running) return DownloadTaskStatus.running;
      if (status == svc.DownloadTaskStatus.complete) return DownloadTaskStatus.complete;
      if (status == svc.DownloadTaskStatus.failed) return DownloadTaskStatus.failed;
      if (status == svc.DownloadTaskStatus.enqueued) return DownloadTaskStatus.enqueued;
      if (status == svc.DownloadTaskStatus.paused) return DownloadTaskStatus.paused;
      if (status == svc.DownloadTaskStatus.canceled) return DownloadTaskStatus.canceled;
      return DownloadTaskStatus.undefined;
  }
}
