import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:port21/features/library/domain/movie.dart';
import 'package:port21/features/library/application/file_verification_service.dart';
import 'package:port21/features/settings/data/settings_repository.dart'; 
import 'package:port21/features/download/data/download_service.dart';
import 'package:port21/features/player/presentation/player_screen.dart';
import 'package:port21/features/player/application/video_launcher.dart';
import 'package:port21/core/utils/path_mapper.dart';
import 'package:port21/features/library/application/library_providers.dart';
import 'package:port21/features/library/data/library_repository.dart';
import 'package:port21/core/utils/file_size_formatter.dart';

class MovieDetailBottomSheet extends ConsumerStatefulWidget {
  final Movie movie;

  const MovieDetailBottomSheet({Key? key, required this.movie}) : super(key: key);

  @override
  ConsumerState<MovieDetailBottomSheet> createState() => _MovieDetailBottomSheetState();
}

class _MovieDetailBottomSheetState extends ConsumerState<MovieDetailBottomSheet> {
  bool _isLoading = false;
  Movie? _existingMovie; // Local match from Library
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkLibraryStatus();
  }

  Future<void> _checkLibraryStatus() async {
     // If widget.movie has ID > 0 (Sonarr ID), it is likely from local library already.
     // If ID < 0 (TMDB ID), we need to check if we have it.
     
     if (widget.movie.id > 0) {
        // Already local
        if (mounted) setState(() {
           _existingMovie = widget.movie;
           _isChecking = false;
        });
        return;
     }

     // Check by TMDB ID
     try {
        final movies = await ref.read(libraryRepositoryProvider).getMovies(forceRefresh: false);
        final match = movies.where((m) => m.tmdbId == widget.movie.tmdbId).firstOrNull;
        if (mounted) setState(() {
           _existingMovie = match;
           _isChecking = false;
        });
     } catch (e) {
        if (mounted) setState(() => _isChecking = false);
     }
  }

  Future<void> _requestMovie() async {
     setState(() => _isLoading = true);
     try {
       final radarr = ref.read(radarrServiceProvider);
       if (radarr == null) throw Exception("Radarr not configured");

       // Get Root Folders (Needed for path)
       final rootFolders = await radarr.getRootFolders();
       if (rootFolders.isEmpty) throw Exception("No Root Folders configured in Radarr");
       final rootPath = rootFolders.first['path'];

       // Get Quality Profile (Default to 1 or first available?)
       // Just use 1 (Any) as safe default for now or fetch.
       // Let's rely on user configuration or fallback.
       // Ideally we should ask user, but "One Click Request" is better.
       // We can assume 'SD' or 'HD' via settings? 
       // Hardcode 1 for now or 4 (Any). 1 fits most defaults.
       
       final success = await radarr.addMovie({
          'title': widget.movie.title,
          'tmdbId': widget.movie.tmdbId,
          'year': widget.movie.year > 0 ? widget.movie.year : 2023, // Fallback if year missing
          'rootFolderPath': rootPath,
          'qualityProfileId': 1, // Default
          'monitored': true,
          'addOptions': {'searchForMovie': true},
          // images? Optional
       });

       if (success) {
          if (mounted) {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Sent! Searching..."), backgroundColor: Colors.green));
             Navigator.pop(context); // Close sheet
          }
       } else {
          throw Exception("Radarr returned failure");
       }

     } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Request Failed: $e"), backgroundColor: Colors.red));
     } finally {
        if (mounted) setState(() => _isLoading = false);
     }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final targetMovie = _existingMovie ?? widget.movie;
    final isAvailable = targetMovie.hasFile; 
    final isMonitored = _existingMovie != null && !isAvailable; // In library but no file
    final isNew = _existingMovie == null;

    final backdropUrl = targetMovie.images.firstWhere((i) => i.coverType == 'backdrop', orElse: () => const MovieImage(coverType: '', url: '')).remoteUrl;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 2,
              width: 60,
              color: const Color(0xFF495057),
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            widget.movie.title.toUpperCase(), 
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 1.5),
          ),
          const SizedBox(height: 16),
          
          // Metadata Row: Flat Chips
          Row(
            children: [
              if (widget.movie.year > 0) ...[
                 _buildFlatChip(context, '${widget.movie.year}'),
                 const SizedBox(width: 8),
              ],
              if (targetMovie.sizeOnDisk > 0) ...[
                 _buildFlatChip(context, FileSizeFormatter.format(targetMovie.sizeOnDisk)),
                 const SizedBox(width: 8),
              ],
              // _buildFlatChip(context, '${widget.movie.runtime} MIN'), // Runtime might not be available in simplified model
             
              if (isAvailable)
                 _buildFlatChip(context, 'AVAILABLE', color: Colors.greenAccent.withOpacity(0.2), textColor: Colors.greenAccent)
              else if (isMonitored)
                 _buildFlatChip(context, 'REQUESTED', color: Colors.orangeAccent.withOpacity(0.2), textColor: Colors.orangeAccent)
              else
                 _buildFlatChip(context, 'NEW', color: Colors.blueAccent.withOpacity(0.2), textColor: Colors.blueAccent),
            ],
          ),
          const SizedBox(height: 24),
          
          Text(
            "SYNOPSIS",
            style: theme.textTheme.labelSmall?.copyWith(color: Colors.grey, letterSpacing: 1.0),
          ),
          const SizedBox(height: 8),
          Text(
            widget.movie.overview,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, color: Colors.white70),
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 32),
          
          // Actions
          if (_isChecking)
             const Center(child: CircularProgressIndicator())
          else
             Row(
            children: [
              Expanded(
                child: SizedBox(
                   height: 56,
                   child: FilledButton.icon(
                      onPressed: _isLoading ? null : () {
                          if (isAvailable) {
                             _playLocal(targetMovie);
                          } else if (isNew) {
                             _requestMovie();
                          } else {
                             // Monitored - maybe force search?
                             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Already requested. Waiting for download.")));
                          }
                      },
                      icon: _isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) 
                        : Icon(isAvailable ? Icons.play_arrow_sharp : (isNew ? Icons.add_circle_outline : Icons.timelapse)),
                      label: Text(
                        _isLoading 
                           ? "PROCESSING..." 
                           : (isAvailable ? "PLAY MOVIE" : (isNew ? "REQUEST" : "MONITORED"))
                      ),
                      style: FilledButton.styleFrom(
                         backgroundColor: isAvailable ? Colors.white : (isNew ? Colors.blueAccent : Colors.grey[800]),
                         foregroundColor: isAvailable ? Colors.black : Colors.white,
                      ),
                   ),
                ),
              ),
              if (isAvailable) ...[
                 const SizedBox(width: 16),
                 SizedBox(
                  height: 56,
                  width: 56,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      side: const BorderSide(color: Color(0xFFEEEEEE), width: 1.0),
                      foregroundColor: const Color(0xFFEEEEEE),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: () { 
                       if (targetMovie.path != null && targetMovie.path!.isNotEmpty) {
                           ref.read(downloadServiceProvider).downloadFile(
                              targetMovie.path!, 
                              targetMovie.title, 
                              'movie_${targetMovie.tmdbId}'
                           );
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Download Queued")));
                       } else {
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No file path available for download")));
                       }
                    },
                    child: const Icon(Icons.download_sharp),
                  ),
                ),
              ]
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Future<void> _playLocal(Movie movie) async {
        setState(() => _isLoading = true);
        
        if (movie.path != null && movie.path!.isNotEmpty) {
           final settings = ref.read(settingsRepositoryProvider).getSettings();
           final ftpUrl = PathMapper.mapToFtpUrl(
              remotePath: movie.path!,
              remotePrefix: settings.remotePathPrefix,
              ftpPrefix: settings.ftpPathPrefix,
              host: settings.ftpHost,
              port: settings.ftpPort,
              user: settings.ftpUser,
              pass: settings.ftpPassword,
              protocol: settings.streamProtocol,
           );
           
           try {
              final absoluteUrl = await ref.read(fileVerificationServiceProvider).verifyFileExists(
                url: ftpUrl,
                host: settings.ftpHost,
                port: settings.ftpPort,
                username: settings.ftpUser,
                password: settings.ftpPassword,
                isSftp: settings.streamProtocol == 'sftp',
              );

              if (absoluteUrl == null) {
                 if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File NOT FOUND on server.'), backgroundColor: Colors.red));
                    setState(() => _isLoading = false);
                 }
                 return;
              }
              
              if (mounted) {
                  VideoLauncher.launch(context, ref, absoluteUrl, 'movie_${movie.tmdbId}');
                  await Future.delayed(const Duration(milliseconds: 500)); // Debounce
                  if (mounted) setState(() => _isLoading = false);
              }

           } catch (e) {
               if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Verification Error: $e'), backgroundColor: Colors.orange));
                  setState(() => _isLoading = false);
               }
           }
        } else {
             if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No file path available")));
                setState(() => _isLoading = false);
             }
        }
  }

  Widget _buildFlatChip(BuildContext context, String label, {IconData? icon, Color? color, Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFF282C34),
        border: Border.all(color: const Color(0xFF495057), width: 0.5),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: textColor ?? Colors.white70),
            const SizedBox(width: 6),
          ],
          Text(
            label, 
            style: TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.bold, 
              color: textColor ?? Colors.white
            ),
          ),
        ],
      ),
    );
  }
}
