import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:port21/features/player/application/sftp_stream_server.dart';
import 'package:port21/features/player/data/playback_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

class PlayerScreen extends ConsumerStatefulWidget {
  final String url;
  final String? contentId;
  
  const PlayerScreen({super.key, required this.url, this.contentId});

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  late final Player _player;
  late final VideoController _controller;
  
  bool _showControls = true;
  bool _isInit = false;
  bool _canPopNow = false;
  BoxFit _fit = BoxFit.contain; // Added: default fit
  
  // Stream Server
  SftpStreamServer? _sftpServer;
  bool _isProxyReady = false;
  
  Timer? _hideTimer;
  Timer? _saveTimer;

  @override
  void initState() {
    super.initState();
    debugPrint("PlayerScreen Init: URL = ${widget.url}");
    
    // Lock Orientation (Post Frame to ensure it overrides previous screen)
    WidgetsBinding.instance.addPostFrameCallback((_) async {
       await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
       await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
       ]);
    });

    // MediaKit Configuration with 64MB Buffer & Aggressive Caching
    _player = Player(configuration: const PlayerConfiguration(
      bufferSize: 64 * 1024 * 1024, 
      vo: 'gpu',
    ));
    // Enforce cache usage via Property (if supported, though bufferSize is main control)
    // _player.setProperty('cache', 'yes'); // Optional, bufferSize implies this usually
    
    _controller = VideoController(_player);
    
    _initPlayer();
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 4), () {
      if (mounted && _player.state.playing) {
        setState(() => _showControls = false);
      }
    });
  }

  void _cancelHideTimer() {
    _hideTimer?.cancel();
    setState(() => _showControls = true);
  }

  void _onUserInteraction() {
     setState(() => _showControls = true);
     _startHideTimer();
  }
  
  // ... (initPlayer method remains similar) ...

  @override
  void dispose() {
    _hideTimer?.cancel();
    _saveTimer?.cancel();
    
    // Save Final Position
    final repo = ref.read(playbackRepositoryProvider);
    final id = widget.contentId ?? widget.url;
    final pos = _player.state.position.inSeconds;
    final dur = _player.state.duration.inSeconds;
    if (dur > 0 && pos > 0) {
        repo.savePosition(id, pos, dur);
    }

    _player.dispose();
    _sftpServer?.stop(); // Stop Proxy
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  // ... (Dialog methods) ...

  Future<void> _onExit() async {
    // 0. Stop Playback Immediately
    await _player.stop();

    // 1. Reset UI
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    
    // 2. Force Portrait
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    // 3. Small Delay to allow rotation config to propagate
    // (Sometimes required on older Android versions or specific OEMs)
    if (Platform.isAndroid) {
       await Future.delayed(const Duration(milliseconds: 100));
    }
    
    if (mounted) {
       setState(() => _canPopNow = true);
       WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) Navigator.of(context).pop();
       });
    }
  }

  void _toggleControls() {
    if (_showControls) {
       _hideTimer?.cancel();
       setState(() => _showControls = false);
    } else {
       _onUserInteraction();
    }
  }
  
  Future<void> _initPlayer() async {
     String playbackUrl = widget.url;
     
     // PROXY LOGIC: If SFTP, start local proxy
     if (widget.url.startsWith('sftp://')) {
        try {
           final uri = Uri.parse(widget.url);
           final userInfo = uri.userInfo.split(':');
           final user = userInfo[0];
           final pass = userInfo.sublist(1).join(':'); 
           final path = Uri.decodeComponent(uri.path); 
           
           _sftpServer = SftpStreamServer();
           await _sftpServer!.start(
              uri.host, 
              uri.port == 0 ? 22 : uri.port, 
              user, 
              Uri.decodeComponent(pass),
              path
           );
           
           playbackUrl = _sftpServer!.url;
           debugPrint("PlayerScreen: Using Proxy URL: $playbackUrl");
           
        } catch (e) {
           debugPrint("PlayerScreen: Proxy Init Failed: $e");
           if (mounted) {
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                 content: Text("Proxy Error: $e"),
                 backgroundColor: Colors.red,
               ));
           }
           return;
        }
     }
     
     if (!mounted) return;

    // init MediaKit Player
    try {
      await _player.open(Media(playbackUrl));
      
      // RESTORE POSITION
      final repo = ref.read(playbackRepositoryProvider);
      final id = widget.contentId ?? widget.url;
      final saved = await repo.getPosition(id);
      if (saved != null && saved.positionSeconds > 0) {
        // seek a bit earlier for context?
        await _player.seek(Duration(seconds: saved.positionSeconds));
      }

      // START SAVE TIMER
      _saveTimer?.cancel();
      _saveTimer = Timer.periodic(const Duration(seconds: 5), (t) {
         if (!mounted) { t.cancel(); return; }
         final pos = _player.state.position.inSeconds;
         final dur = _player.state.duration.inSeconds;
         if (dur > 0 && pos > 0) {
             repo.savePosition(id, pos, dur);
         }
      });

      setState(() { 
          _isInit = true; 
          _isProxyReady = true;
      });
    } catch (e) {
      debugPrint("MediaKit Init Error: $e");
       if (mounted) {
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
             content: Text("Video Error: $e"),
             backgroundColor: Colors.red,
           ));
       }
    }
  }
  


  void _showTracksDialog() {
      showModalBottomSheet(
        context: context,
        backgroundColor: const Color(0xFF151515),
        builder: (context) {
           return DefaultTabController(
             length: 2,
             child: Column(
               children: [
                 const TabBar(
                   tabs: [Tab(text: "Audio"), Tab(text: "Subtitles")],
                   labelColor: Colors.white,
                   unselectedLabelColor: Colors.grey,
                   indicatorColor: Colors.tealAccent,
                 ),
                 Expanded(
                   child: TabBarView(
                     children: [
                       // Audio Tracks
                       ListView(
                         children: _player.state.tracks.audio.map((e) {
                            final isSelected = _player.state.track.audio == e;
                            return ListTile(
                              title: Text(e.title ?? e.language ?? e.id, style: const TextStyle(color: Colors.white)),
                              trailing: isSelected ? const Icon(Icons.check, color: Colors.tealAccent) : null,
                              onTap: () {
                                _player.setAudioTrack(e);
                                Navigator.pop(context);
                              },
                            );
                         }).toList(),
                       ),
                       // Subtitles
                       ListView(
                          children: _player.state.tracks.subtitle.map((e) {
                            final isSelected = _player.state.track.subtitle == e;
                            return ListTile(
                              title: Text(e.title ?? e.language ?? e.id, style: const TextStyle(color: Colors.white)),
                              trailing: isSelected ? const Icon(Icons.check, color: Colors.tealAccent) : null,
                              onTap: () {
                                _player.setSubtitleTrack(e);
                                Navigator.pop(context);
                              },
                            );
                         }).toList(),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           );
        },
      );
  }

  void _showCastDialog() async {
     final lanUrl = await _sftpServer?.getLanUrl() ?? widget.url;
     
     if (!mounted) return;
     showDialog(
       context: context, 
       builder: (context) => AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text("Cast / Stream to TV", style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               const Text("Enter this URL in your TV browser or VLC:", style: TextStyle(color: Colors.grey)),
               const SizedBox(height: 16),
               SelectableText(
                 lanUrl, 
                 style: const TextStyle(color: Colors.tealAccent, fontSize: 18, fontWeight: FontWeight.bold),
               ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("CLOSE", style: TextStyle(color: Colors.white))
            ),
          ],
       )
     );
  }



   @override
  Widget build(BuildContext context) {
    if (!_isProxyReady) {
       return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator(color: Colors.tealAccent)),
       );
    }
  
    return PopScope(
      canPop: _canPopNow,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _onExit();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.center,
          children: [
             // ... rest of body ...
          // Video Layer
          SizedBox.expand(
            child: Video(controller: _controller, fit: _fit),
          ),
          
          // Gesture Layer
          GestureDetector(
            onTap: _toggleControls,
            behavior: HitTestBehavior.translucent,
            child: Container(color: Colors.transparent),
          ),

          // Controls Layer
          if (_showControls)
            Container(
              color: Colors.black38,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SafeArea(
                child: Column(
                  children: [
                    // Top Bar
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                          onPressed: _onExit,
                        ),
                        const Spacer(),
                        // Fit Toggle Button
                        IconButton(
                           icon: Icon(
                              _fit == BoxFit.cover ? Icons.crop_free : 
                              _fit == BoxFit.fill ? Icons.aspect_ratio : Icons.fit_screen, 
                              color: Colors.white
                           ),
                           tooltip: "Change Aspect Ratio",
                           onPressed: () {
                              setState(() {
                                 if (_fit == BoxFit.contain) {
                                    _fit = BoxFit.cover; // Zoom/Crop
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Zoom to Fill"), duration: Duration(milliseconds: 500)));
                                 } else if (_fit == BoxFit.cover) {
                                    _fit = BoxFit.fill; // Stretch
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Stretch"), duration: Duration(milliseconds: 500)));
                                 } else {
                                    _fit = BoxFit.contain; // Normal
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Original Fit"), duration: Duration(milliseconds: 500)));
                                 }
                              });
                           },
                        ),
                        // Cast Button
                        IconButton(
                           icon: const Icon(Icons.cast, color: Colors.white),
                           onPressed: _showCastDialog,
                        ),
                        // Tracks Button
                        IconButton(
                           icon: const Icon(Icons.closed_caption, color: Colors.white),
                           onPressed: _showTracksDialog,
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Center Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 48,
                          color: Colors.white,
                          icon: const Icon(Icons.replay_10),
                          onPressed: () {
                              final pos = _player.state.position;
                              _player.seek(pos - const Duration(seconds: 10));
                          },
                        ),
                        const SizedBox(width: 32),
                        StreamBuilder<bool>(
                          stream: _player.stream.playing,
                          builder: (context, snapshot) {
                            final isPlaying = snapshot.data ?? false;
                            return IconButton(
                              iconSize: 64,
                              color: Colors.white,
                              icon: Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled),
                              onPressed: () {
                                 _player.playOrPause();
                              },
                            );
                          }
                        ),
                        const SizedBox(width: 32),
                         IconButton(
                          iconSize: 48,
                          color: Colors.white,
                          icon: const Icon(Icons.forward_10),
                          onPressed: () {
                              final pos = _player.state.position;
                              _player.seek(pos + const Duration(seconds: 10));
                          },
                        ),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Bottom Bar
                    StreamBuilder<Duration>(
                      stream: _player.stream.position,
                      builder: (context, snapshot) {
                         final pos = snapshot.data ?? Duration.zero;
                         final duration = _player.state.duration;
                         
                         return Padding(
                           padding: const EdgeInsets.only(bottom: 20),
                           child: Row(
                             children: [
                                 Text(
                                   _formatDuration(pos),
                                   style: const TextStyle(color: Colors.white),
                                 ),
                                 Expanded(
                                   child: Slider(
                                     value: pos.inSeconds.toDouble().clamp(0, duration.inSeconds.toDouble()),
                                     min: 0,
                                     max: duration.inSeconds.toDouble(),
                                     activeColor: Colors.tealAccent,
                                     inactiveColor: Colors.white24,
                                     onChanged: (val) {
                                        _player.seek(Duration(seconds: val.toInt()));
                                     },
                                   ),
                                 ),
                                 Text(
                                   _formatDuration(duration),
                                   style: const TextStyle(color: Colors.white),
                                 ),
                             ],
                           ),
                         );
                      }
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    ),
   );
  }
  
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(d.inHours);
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return d.inHours > 0 ? "$hours:$minutes:$seconds" : "$minutes:$seconds";
  }
}
