import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:port21/features/library/domain/series.dart';
import 'package:port21/features/library/domain/episode.dart'; 
import 'package:port21/features/library/application/library_providers.dart'; 
import 'package:port21/features/settings/data/settings_repository.dart';
import 'package:port21/features/download/data/download_service.dart';
import 'package:port21/core/utils/path_mapper.dart'; 
import 'package:port21/features/library/application/file_verification_service.dart'; 
import 'package:port21/features/player/application/video_launcher.dart'; 
import 'package:go_router/go_router.dart';
import 'package:isar/isar.dart'; 
import 'package:port21/features/download/domain/downloaded_media.dart'; 
import 'package:port21/features/library/data/library_repository.dart';

class SeriesDetailBottomSheet extends ConsumerStatefulWidget {
  final Series series;

  const SeriesDetailBottomSheet({Key? key, required this.series}) : super(key: key);

  @override
  ConsumerState<SeriesDetailBottomSheet> createState() => _SeriesDetailBottomSheetState();
}

class _SeriesDetailBottomSheetState extends ConsumerState<SeriesDetailBottomSheet> {
  bool _isLoading = false;
  Series? _existingSeries;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _checkLibraryStatus();
  }

  Future<void> _checkLibraryStatus() async {
     if (widget.series.id > 0) {
        if (mounted) setState(() {
           _existingSeries = widget.series;
           _isChecking = false;
        });
        return;
     }

     try {
        final seriesList = await ref.read(libraryRepositoryProvider).getSeries(forceRefresh: false);
        final match = seriesList.where((s) => s.tmdbId == widget.series.tmdbId).firstOrNull;
        if (mounted) setState(() {
           _existingSeries = match;
           _isChecking = false;
        });
     } catch (e) {
        if (mounted) setState(() => _isChecking = false);
     }
  }

  Future<void> _requestSeries() async {
     setState(() => _isLoading = true);
     try {
       final sonarr = ref.read(sonarrServiceProvider);
       if (sonarr == null) throw Exception("Sonarr not configured");

       // Lookup first to get TVDB ID and valid payload structure
       final lookupResults = await sonarr.lookup("tmdb:${widget.series.tmdbId}");
       if (lookupResults.isEmpty) throw Exception("Series not found in Sonarr lookup");
       
       final payload = lookupResults.first;
       
       // Get Root Paths
       final rootFolders = await sonarr.getRootFolders();
       if (rootFolders.isEmpty) throw Exception("No Root Folders configured in Sonarr");
       final rootPath = rootFolders.first['path'];
       
       // Get Quality Profile
       final profiles = await sonarr.getQualityProfiles();
       if (profiles.isEmpty) throw Exception("No Quality Profiles configured in Sonarr");
       final profileId = profiles.first['id'];

       // Modify Payload
       payload['rootFolderPath'] = rootPath;
       payload['qualityProfileId'] = profileId; // Dynamic
       payload['monitored'] = true;
       payload['addOptions'] = {'searchForMissingEpisodes': true};
       
       final success = await sonarr.addSeries(payload);

       if (success) {
          if (mounted) {
             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Request Sent! Searching..."), backgroundColor: Colors.green));
             Navigator.pop(context); 
          }
       } else {
          throw Exception("Sonarr returned failure");
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
    final targetSeries = _existingSeries ?? widget.series;
    final isLibraryField = _existingSeries != null; // It is in our library (tracked)
    
    // If not in library, we show Request UI.
    // If in library, we show Episodes.

    final episodesAsync = isLibraryField 
        ? ref.watch(fetchEpisodesProvider(targetSeries.id)) 
        : const AsyncValue<List<Episode>>.loading(); // Or data([]) if not fetching
    
    return DraggableScrollableSheet( 
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
                        widget.series.title.toUpperCase(), 
                        style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w900, letterSpacing: 1.5),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          if (isLibraryField) _buildFlatChip(context, '${targetSeries.episodeCount} EPISODES'),
                          if (isLibraryField) const SizedBox(width: 8),
                          _buildFlatChip(context, isLibraryField ? (targetSeries.status ?? 'UNKNOWN').toUpperCase() : 'NEW', 
                              color: isLibraryField ? Colors.green.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
                              textColor: isLibraryField ? Colors.greenAccent : Colors.blueAccent),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Text(
                        widget.series.overview,
                        style: theme.textTheme.bodyMedium?.copyWith(height: 1.5, color: Colors.white70),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 24),
                      
                      // Action Logic
                      if (_isChecking)
                         const Center(child: CircularProgressIndicator())
                      else if (!isLibraryField)
                         SizedBox(
                           width: double.infinity,
                           height: 56,
                           child: FilledButton.icon(
                              onPressed: _isLoading ? null : _requestSeries,
                              icon: _isLoading 
                                ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black))
                                : const Icon(Icons.add_circle_outline),
                              label: Text(_isLoading ? "PROCESSING..." : "REQUEST SERIES"),
                              style: FilledButton.styleFrom(backgroundColor: Colors.blueAccent),
                           ),
                         )
                      else
                         const Divider(color: Colors.white10),
                    ],
                  ),
                ),
              ),

              // Episodes List (Only if in Library)
              if (isLibraryField)
                episodesAsync.when(
                  data: (episodes) {
                     if (episodes.isEmpty) {
                        return const SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(20), child: Center(child: Text("Monitoring... No episodes yet."))));
                     }
                     
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
                              seriesTmdbId: targetSeries.tmdbId, 
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
                     int queued = 0;
                     for (final ep in episodes) {
                       if (ep.hasFile && ep.path != null) {
                          final title = "S${seasonNumber.toString().padLeft(2, '0')}E${ep.episodeNumber.toString().padLeft(2, '0')} - ${ep.title ?? 'Episode'}";
                          final contentId = 'episode_${seriesTmdbId}_s${ep.seasonNumber}_e${ep.episodeNumber}';
                          ref.read(downloadServiceProvider).downloadFile(ep.path!, title, contentId);
                          queued++;
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
  bool _isDownloaded = false; 

  @override
  void initState() {
    super.initState();
    _checkDownloadStatus();
  }

  Future<void> _checkDownloadStatus() async {
     final contentId = 'episode_${widget.seriesTmdbId}_s${widget.episode.seasonNumber}_e${widget.episode.episodeNumber}';
     final isar = ref.read(isarProvider);
     final media = await isar.downloadedMedias.filter().contentIdEqualTo(contentId).statusEqualTo('completed').findFirst();
     if (mounted && media != null) {
        setState(() {
           _isDownloaded = true;
        });
     }
  }

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
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
                       if (widget.episode.sizeOnDisk > 0) ...[
                          const SizedBox(width: 8),
                          Text(
                             _formatSize(widget.episode.sizeOnDisk),
                             style: const TextStyle(color: Colors.white38, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                       ]
                    ],
                  ),
               ],
            ),
          ),
          if (isAvailable) ...[
             _isLoading 
            ? const SizedBox(width: 48, height: 48, child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))))
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   IconButton(
                    icon: const Icon(Icons.play_arrow_sharp, color: Colors.white),
                    onPressed: () async {
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
                  ),
                  if (_isDownloaded)
                      IconButton(
                        icon: const Icon(Icons.check_circle, color: Colors.greenAccent),
                        onPressed: () {
                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Episode Downloaded")));
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
            )
          ] else
            const SizedBox(), 
        ],
      ),
    );
  }
  String _formatSize(int bytes) {
    if (bytes <= 0) return "";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    var i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }
}
