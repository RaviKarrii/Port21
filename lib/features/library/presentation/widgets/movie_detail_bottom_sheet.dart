import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:port21/features/library/domain/movie.dart';
import 'package:port21/features/library/application/file_verification_service.dart';
import 'package:port21/features/settings/data/settings_repository.dart'; // For API key
import 'package:port21/features/download/data/download_service.dart';
import 'package:port21/features/player/presentation/player_screen.dart';
import 'package:port21/features/player/application/video_launcher.dart';
import 'package:port21/core/utils/path_mapper.dart';

// Helper to construct image URL
// Radarr images are /MediaCover/10/poster.jpg?apikey=...
// We need to resolve the full URL.
String? getPosterUrl(Movie movie, String baseUrl, String apiKey) {
  final poster = movie.images.firstWhere(
    (img) => img.coverType == 'Poster',
    orElse: () => const MovieImage(coverType: '', url: ''),
  );
  if (poster.url.isNotEmpty) {
    // If remoteUrl is present and valid, use it? Usually 'url' is relative path like /MediaCover/...
    // So we append it to base URL.
    return '$baseUrl${poster.url}?apikey=$apiKey';
  }
  return null;
}

class MovieDetailBottomSheet extends ConsumerStatefulWidget {
  final Movie movie;

  const MovieDetailBottomSheet({Key? key, required this.movie}) : super(key: key);

  @override
  ConsumerState<MovieDetailBottomSheet> createState() => _MovieDetailBottomSheetState();
}

class _MovieDetailBottomSheetState extends ConsumerState<MovieDetailBottomSheet> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final sizeInGb = (widget.movie.sizeOnDisk / (1024 * 1024 * 1024)).toStringAsFixed(2);
    
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
          // Handle - replaced with industrial bar
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
              _buildFlatChip(context, '${widget.movie.runtime} MIN'),
              const SizedBox(width: 8),
              if (widget.movie.hasFile)
                 _buildFlatChip(context, '${sizeInGb} GB', icon: Icons.sd_storage)
              else
                 _buildFlatChip(context, 'MISSING', color: Colors.redAccent.withOpacity(0.2), textColor: Colors.redAccent),
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
          
          // Actions: Big Flat Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                   height: 56,
                   child: FilledButton.icon(
                      onPressed: (widget.movie.hasFile && !_isLoading)
                        ? () async {
                            setState(() => _isLoading = true);
                            
                            // Check for path
                            if (widget.movie.path != null && widget.movie.path!.isNotEmpty) {
                               // Get Settings
                               final settings = ref.read(settingsRepositoryProvider).getSettings();
                               
                               // Map Path to FTP URL
                               final ftpUrl = PathMapper.mapToFtpUrl(
                                  remotePath: widget.movie.path!,
                                  remotePrefix: settings.remotePathPrefix,
                                  ftpPrefix: settings.ftpPathPrefix,
                                  host: settings.ftpHost,
                                  port: settings.ftpPort,
                                  user: settings.ftpUser,
                                  pass: settings.ftpPassword,
                                  protocol: settings.streamProtocol,
                               );
                               
                                // Prepare Settings for Verification
                                final isSftpStrict = settings.streamProtocol == 'sftp';
                                
                                String? absoluteUrl; 

                                try {
                                  // Verify and Get Corrected URL (Silent)
                                  absoluteUrl = await ref.read(fileVerificationServiceProvider).verifyFileExists(
                                    url: ftpUrl,
                                    host: settings.ftpHost,
                                    port: settings.ftpPort,
                                    username: settings.ftpUser,
                                    password: settings.ftpPassword,
                                    isSftp: isSftpStrict,
                                  );

                                  if (absoluteUrl == null) {
                                     print('UI: absoluteUrl is null. Showing Not Found SnackBar.');
                                     if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('File NOT FOUND on server.'),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                     }
                                     if (mounted) setState(() => _isLoading = false);
                                     return;
                                  }
                                } catch (e) {
                                   print('UI: Exception caught: $e');
                                   if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Verification Error: $e'),
                                          backgroundColor: Colors.orange,
                                        ),
                                      );
                                   }
                                   if (mounted) setState(() => _isLoading = false);
                                   return; 
                                }

                                if (!context.mounted) {
                                  print('UI: Context not mounted after verify.');
                                  return;
                                }
                                
                               // Navigation to player (GoRouter)
                               if (context.mounted) {
                                  VideoLauncher.launch(
                                    context,
                                    ref,
                                    absoluteUrl ?? ftpUrl,
                                    'movie_${widget.movie.tmdbId}',
                                  );
                                  // We keep loading true slightly longer to prevent rapid re-taps during push
                                  await Future.delayed(const Duration(milliseconds: 500));
                                  if (mounted) setState(() => _isLoading = false);
                               }
                            } else {
                               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("No file path available")));
                               if (mounted) setState(() => _isLoading = false);
                            }
                          } 
                        : null,
                      icon: _isLoading 
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black)) 
                        : const Icon(Icons.play_arrow_sharp),
                      label: Text(_isLoading ? "VERIFYING..." : "PLAY MOVIE"),
                   ),
                ),
              ),
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
                     ref.read(downloadServiceProvider).downloadFile(
                       widget.movie.path ?? '', 
                       widget.movie.title,
                       'movie_${widget.movie.tmdbId}',
                     );
                     Navigator.pop(context);
                     ScaffoldMessenger.of(context).showSnackBar(
                       const SnackBar(content: Text('Initializing Download Protocol...')),
                     );
                  },
                  child: const Icon(Icons.download_sharp),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
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
