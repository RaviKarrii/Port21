import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; // Added
import 'package:port21/features/library/domain/series.dart';
import 'package:port21/features/library/domain/episode.dart'; // Added
import 'package:port21/features/library/application/library_providers.dart'; // Added
import 'package:port21/features/settings/data/settings_repository.dart';
import 'package:port21/features/download/data/download_service.dart';

import 'package:port21/core/utils/path_mapper.dart'; // Added
import 'package:port21/features/library/application/file_verification_service.dart'; // Added
import 'package:port21/features/player/application/video_launcher.dart'; // Added
import 'package:go_router/go_router.dart'; // Added

class SeriesDetailBottomSheet extends ConsumerWidget {
  final Series series;

  const SeriesDetailBottomSheet({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final episodeCount = series.episodeCount;
    final statusSafe = series.status ?? 'Unknown';
    final episodesAsync = ref.watch(fetchEpisodesProvider(series.id)); // Watch episodes
    
    return DraggableScrollableSheet( // Use Draggable for better list experience
      initialChildSize: 0.9,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              // Header Sliver
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Center(
                        child: Container(
                          height: 4,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(2)
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        series.title.toUpperCase(), 
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          _buildFlatChip(context, '$episodeCount EPISODES'),
                          const SizedBox(width: 8),
                          _buildFlatChip(context, statusSafe.toUpperCase(), 
                              color: statusSafe.toLowerCase() == 'continuing' ? Colors.green.withOpacity(0.2) : Colors.grey.withOpacity(0.2),
                              textColor: statusSafe.toLowerCase() == 'continuing' ? Colors.greenAccent : Colors.white70),
                          const SizedBox(width: 8),
                          if (series.episodeFileCount > 0)
                             _buildFlatChip(context, 'FILES: ${series.episodeFileCount}', icon: Icons.sd_storage),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        series.overview,
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, color: Colors.white70),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 24),
                      const Divider(color: Colors.white10),
                    ],
                  ),
                ),
              ),

              // Episodes Logic
              episodesAsync.when(
                data: (episodes) {
                   final seasons = <int, List<Episode>>{};
                   for (var ep in episodes) {
                     if (!seasons.containsKey(ep.seasonNumber)) seasons[ep.seasonNumber] = [];
                     seasons[ep.seasonNumber]!.add(ep);
                   }
                   final sortedSeasonNums = seasons.keys.toList()..sort();

                   return SliverList(
                     delegate: SliverChildBuilderDelegate(
                       (context, index) {
                         final seasonNum = sortedSeasonNums[index];
                         final seasonEpisodes = seasons[seasonNum]!;
                         seasonEpisodes.sort((a, b) => a.episodeNumber.compareTo(b.episodeNumber));
                                                  return _SeasonExpansionTile(
                            seasonNumber: seasonNum, 
                            episodes: seasonEpisodes,
                            seriesTmdbId: series.tmdbId, // Pass ID
                          );
                       },
                       childCount: sortedSeasonNums.length,
                     ),
                   );
                },
                loading: () => const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator())),
                error: (e, s) => SliverToBoxAdapter(child: Center(child: Text("Error: $e"))),
              ),
              
              const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
            ],
          ),
        );
      }
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

class _SeasonExpansionTile extends ConsumerWidget {
  final int seasonNumber;
  final List<Episode> episodes;
  final int seriesTmdbId;

  const _SeasonExpansionTile({required this.seasonNumber, required this.episodes, required this.seriesTmdbId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Count available files
    final availableCount = episodes.where((e) => e.hasFile).length;

    return Container(
      decoration: BoxDecoration(
         color: const Color(0xFF151515),
         border: Border(bottom: BorderSide(color: Colors.grey[800]!, width: 0.5)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          collapsedBackgroundColor: const Color(0xFF151515),
          backgroundColor: const Color(0xFF0A0A0A),
          title: Row(
            children: [
              Text(
                "SEASON $seasonNumber",
                style: GoogleFonts.robotoCondensed(
                  fontWeight: FontWeight.w900, fontSize: 18, letterSpacing: 1.0, color: Colors.white,
                ),
              ),
              const Spacer(),
              if (availableCount > 0)
                TextButton.icon(
                  onPressed: () async {
                     // Download Season Logic
                     int queued = 0;
                     for (final ep in episodes) {
                       if (ep.hasFile && ep.path != null) {
                          // Format: "S01E01 - Title"
                          final title = "S${seasonNumber.toString().padLeft(2, '0')}E${ep.episodeNumber.toString().padLeft(2, '0')} - ${ep.title ?? 'Episode'}";
                          final contentId = 'episode_${seriesTmdbId}_s${ep.seasonNumber}_e${ep.episodeNumber}';
                          ref.read(downloadServiceProvider).downloadFile(ep.path!, title, contentId);
                          queued++;
                          // Small delay to ensure order
                          await Future.delayed(const Duration(milliseconds: 50));
                       }
                     }
                     if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Queued $queued episodes for download")));
                     }
                  },
                  icon: const Icon(Icons.download_for_offline, size: 18, color: Colors.tealAccent),
                  label: const Text("DOWNLOAD SEASON", style: TextStyle(color: Colors.tealAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 8)),
                )
            ],
          ),
          children: episodes.map((ep) => _EpisodeTile(episode: ep, seriesTmdbId: seriesTmdbId)).toList(),
        ),
      ),
    );
  }
}

class _EpisodeTile extends ConsumerStatefulWidget {
  final Episode episode;
  final int seriesTmdbId;
  const _EpisodeTile({required this.episode, required this.seriesTmdbId});

  @override
  ConsumerState<_EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends ConsumerState<_EpisodeTile> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // "Available" Logic
    final isAvailable = widget.episode.hasFile;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(color: Colors.grey[800]!, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 30,
            child: Text(
              widget.episode.episodeNumber.toString(),
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                   widget.episode.title ?? "Unknown Episode",
                   style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Colors.white),
                 ),
                 if (widget.episode.overview != null && widget.episode.overview!.isNotEmpty)
                   Padding(
                     padding: const EdgeInsets.only(top: 4.0),
                     child: Text(
                       widget.episode.overview!,
                       maxLines: 2, overflow: TextOverflow.ellipsis,
                       style: const TextStyle(color: Colors.white54, fontSize: 12),
                     ),
                   ),
                 const SizedBox(height: 8),
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                   decoration: BoxDecoration(
                     color: isAvailable ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                     border: Border.all(color: isAvailable ? Colors.green.withOpacity(0.5) : Colors.red.withOpacity(0.5), width: 0.5),
                   ),
                   child: Text(
                     isAvailable ? "AVAILABLE" : "MISSING", 
                     style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isAvailable ? Colors.greenAccent : Colors.redAccent),
                   ),
                 ),
              ],
            ),
          ),
          if (isAvailable)
            _isLoading 
            ? const SizedBox(width: 48, height: 48, child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))))
            : IconButton(
              icon: const Icon(Icons.play_arrow_sharp, color: Colors.white),
              onPressed: () async {
                 // Play Logic Copy
                  setState(() => _isLoading = true);
                  if (widget.episode.path != null && widget.episode.path!.isNotEmpty) {
                    final settings = ref.read(settingsRepositoryProvider).getSettings();
                    final ftpUrl = PathMapper.mapToFtpUrl(
                        remotePath: widget.episode.path!,
                        remotePrefix: settings.remotePathPrefix,
                        ftpPrefix: settings.ftpPathPrefix,
                        host: settings.ftpHost,
                        port: settings.ftpPort,
                        user: settings.ftpUser,
                        pass: settings.ftpPassword,
                        protocol: settings.streamProtocol,
                    );
                    ref.read(fileVerificationServiceProvider).verifyFileExists(
                        url: ftpUrl,
                        host: settings.ftpHost,
                        port: settings.ftpPort,
                        username: settings.ftpUser,
                        password: settings.ftpPassword,
                        isSftp: settings.streamProtocol == 'sftp',
                    ).then((absoluteUrl) async {
                        if (context.mounted) {
                           if (absoluteUrl == null) {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File NOT FOUND on server.'), backgroundColor: Colors.red));
                           } else {
                               final contentId = 'episode_${widget.seriesTmdbId}_s${widget.episode.seasonNumber}_e${widget.episode.episodeNumber}';
                               VideoLauncher.launch(
                                 context,
                                 ref,
                                 absoluteUrl,
                                 contentId,
                               );
                           }
                        }
                        if (mounted) setState(() => _isLoading = false);
                    }).catchError((e) {
                         if (mounted) setState(() => _isLoading = false);
                    });
                  } else {
                    if (mounted) setState(() => _isLoading = false);
                  }
              },
            )
          else
            IconButton(
              icon: const Icon(Icons.download_sharp, color: Colors.white70),
              onPressed: () {
                 if (widget.episode.path != null) {
                    final title = "S${widget.episode.seasonNumber.toString().padLeft(2, '0')}E${widget.episode.episodeNumber.toString().padLeft(2, '0')} - ${widget.episode.title ?? 'Episode'}";
                    final contentId = 'episode_${widget.seriesTmdbId}_s${widget.episode.seasonNumber}_e${widget.episode.episodeNumber}';
                    ref.read(downloadServiceProvider).downloadFile(widget.episode.path!, title, contentId);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Download Queued")));
                 }
              },
            ),
        ],
      ),
    );
  }
}
