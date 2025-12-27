import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:port21/features/library/application/library_providers.dart';
import 'package:port21/features/library/domain/movie.dart';
import 'package:port21/features/library/domain/series.dart';
import 'package:port21/features/settings/data/settings_repository.dart';
import 'package:port21/features/library/presentation/widgets/movie_detail_bottom_sheet.dart';
import 'package:port21/features/library/presentation/widgets/series_detail_bottom_sheet.dart';
import 'package:port21/core/utils/poster_helper.dart';
import 'package:port21/features/player/data/playback_repository.dart';
import 'package:port21/features/player/domain/playback_position.dart'; // Added



class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Library'),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Movies"),
              Tab(text: "Series"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MovieGridWidget(),
            SeriesGridWidget(),
          ],
        ),
      ),
    );
  }
}

class MovieGridWidget extends ConsumerWidget {
  const MovieGridWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final moviesAsync = ref.watch(fetchMoviesProvider);
    final settings = ref.watch(settingsRepositoryProvider).getSettings();
    final itemPositions = ref.watch(playbackPositionsProvider).valueOrNull ?? [];

    return moviesAsync.when(
      data: (movies) {
        if (movies.isEmpty) {
          return const Center(child: Text("No movies found. Check Settings."));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final movie = movies[index];
            print("LIB: Movie: ${movie.title} | Images: ${movie.images.map((i) => '${i.coverType}:${i.url}').toList()}");
            final posterUrl = PosterHelper.getMoviePosterUrl(movie, settings.radarrUrl, settings.radarrApiKey);

             // Progress Logic
            final pos = itemPositions.firstWhere(
               (p) => p.contentId == movie.tmdbId.toString(), 
               orElse: () => PlaybackPosition(), // Empty
            );
            final progress = (pos.durationSeconds > 0) ? (pos.positionSeconds / pos.durationSeconds) : 0.0;

            return _buildMediaCard(
              context: context,
              title: movie.title,
              posterUrl: posterUrl,
              hasFile: movie.hasFile,
              progress: progress, // New param
              onTap: () {
                 showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => MovieDetailBottomSheet(movie: movie),
                );
              },
              apiKey: settings.radarrApiKey,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }
}

class SeriesGridWidget extends ConsumerWidget {
  const SeriesGridWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seriesAsync = ref.watch(fetchSeriesProvider);
    final settings = ref.watch(settingsRepositoryProvider).getSettings();

    return seriesAsync.when(
      data: (seriesList) {
        if (seriesList.isEmpty) {
          return const Center(child: Text("No series found. Check Settings."));
        }
        return GridView.builder(
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, 
            childAspectRatio: 2 / 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: seriesList.length,
          itemBuilder: (context, index) {
            final series = seriesList[index];
            final posterUrl = PosterHelper.getSeriesPosterUrl(series, settings.sonarrUrl, settings.sonarrApiKey);

            return _buildMediaCard(
              context: context,
              title: series.title,
              posterUrl: posterUrl,
              hasFile: series.episodeFileCount > 0, 
              onTap: () {
                 showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SeriesDetailBottomSheet(series: series),
                );
              }
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }
}

// Reusable Media Card
Widget _buildMediaCard({
    required BuildContext context,
    required String title,
    required String? posterUrl,
    required bool hasFile,
    required VoidCallback onTap,
    String? apiKey,
    double progress = 0.0, // New param
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF495057), width: 0.5),
        color: const Color(0xFF151515),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (posterUrl != null)
            CachedNetworkImage(
              imageUrl: posterUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) {
                  print("IMAGE ERROR for $url: $error");
                  return _buildPlaceholder(debugText: "ERR: $url\n$error");
              },
              placeholder: (context, url) => _buildPlaceholder(debugText: "Loading $url..."),
              httpHeaders: apiKey != null ? {"X-Api-Key": apiKey} : null,
            )
          else
            _buildPlaceholder(debugText: posterUrl ?? "NULL URL"),
          
          if (hasFile)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                color: const Color(0xFFEEEEEE),
                child: const Text(
                  "LOC",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            
          // Add Title Overlay at bottom for "Index Card" feel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                 Container(
                    color: Colors.black.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                    width: double.infinity,
                    child: Text(
                      title.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white, 
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ),
                if (progress > 0.05) // Hide if barely started
                  LinearProgressIndicator(
                    value: progress, 
                    minHeight: 3, 
                    color: Colors.tealAccent, 
                    backgroundColor: Colors.black45
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildPlaceholder({String? debugText}) {
  return Container(
    color: const Color(0xFF151515),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.movie, color: Color(0xFF495057)),
          if (debugText != null)
             Padding(
               padding: const EdgeInsets.all(2.0),
               child: Text(
                 debugText,
                 style: const TextStyle(color: Colors.red, fontSize: 8),
                 textAlign: TextAlign.center,
                 maxLines: 4, 
                 overflow: TextOverflow.ellipsis,
               ),
             ),
        ],
      ),
    ),
  );
}
