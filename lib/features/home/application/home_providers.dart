import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../library/application/library_providers.dart';
import '../../library/domain/movie.dart';
import '../../library/domain/series.dart';
import '../../player/data/playback_repository.dart';
import '../../player/domain/playback_position.dart';

part 'home_providers.g.dart';

// Union type for Home content
class HomeContent {
  final String title;
  final String? posterUrl;
  final String? backdropUrl;
  final String? overview;
  final String contentId; // ID for playback lookup
  final bool isMovie;
  final dynamic originalItem; // Movie or Series object
  final double progress; // 0.0 to 1.0

  HomeContent({
    required this.title,
    this.posterUrl,
    this.backdropUrl,
    this.overview,
    required this.contentId,
    required this.isMovie,
    required this.originalItem,
    this.progress = 0.0,
  });
}

@riverpod
Future<List<HomeContent>> recentlyAddedRails(RecentlyAddedRailsRef ref) async {
  // Combine Movies and Series? Or just return mixed?
  // Let's return mixed for now, sorted by ID (proxy for recency)
  final movies = await ref.watch(fetchMoviesProvider.future);
  final series = await ref.watch(fetchSeriesProvider.future);

  final mixed = <HomeContent>[];

  // Map Movies
  for (var m in movies) {
    mixed.add(HomeContent(
      title: m.title,
      posterUrl: m.images.firstWhere((i) => i.coverType == 'poster', orElse: () => MovieImage(coverType: 'none', url: '')).remoteUrl ?? m.images.firstOrNull?.url,
      // Use remoteUrl if available, fall back to whatever we have. 
      // Note: LibraryRepo usually populates this with TMDB url now.
      contentId: 'movie_${m.tmdbId}',
      isMovie: true,
      originalItem: m,
      overview: m.overview,
    ));
  }

  // Map Series
  for (var s in series) {
    mixed.add(HomeContent(
      title: s.title,
      posterUrl: s.images.firstWhere((i) => i.coverType == 'poster', orElse: () => SeriesImage(coverType: 'none', url: '')).remoteUrl ?? s.images.firstOrNull?.url,
      contentId: s.tmdbId.toString(), // or TVDB? 
      isMovie: false,
      originalItem: s,
      overview: s.overview,
    ));
  }
  
  // Shuffle or Sort? ID based sort (descending) approximates "Recently Added"
  // Assuming higher ID = newer in DB.
  // Actually, random shuffle is better for "Discovery" if we don't track dateAdded.
  mixed.shuffle(); 
  
  return mixed.take(10).toList();
}

@riverpod
Future<List<HomeContent>> continueWatchingRail(ContinueWatchingRailRef ref) async {
  final positions = ref.watch(playbackPositionsProvider).valueOrNull ?? [];
  if (positions.isEmpty) return [];

  final movies = await ref.watch(fetchMoviesProvider.future);
  final series = await ref.watch(fetchSeriesProvider.future);
  
  final continuing = <HomeContent>[];

  // Sort positions by last updated? The Repo doesn't have updated timestamp visible easily 
  // without modifying schema. For now, just take them as they come.
  
  for (var p in positions) {
    if (p.positionSeconds < 60) continue; // Skip minimal progress
    if (p.positionSeconds >= p.durationSeconds * 0.95) continue; // Skip finished

    // Find match
    // Check Movie
    try {
      final m = movies.firstWhere((m) => 'movie_${m.tmdbId}' == p.contentId);
      continuing.add(HomeContent(
        title: m.title,
        posterUrl: m.images.firstWhere((i) => i.coverType == 'poster', orElse: () => MovieImage(coverType: 'none', url: '')).remoteUrl,
        contentId: p.contentId,
        isMovie: true,
        originalItem: m,
        progress: p.durationSeconds > 0 ? p.positionSeconds / p.durationSeconds : 0.0,
      ));
      continue;
    } catch (_) {}

    // Check Series (ID might be mapped differently, need to be careful)
    // Series playback usually tracks EPISODE ID. This is tricky.
    // If we play series, we save by filename or episode ID.
    // If we only have series metadata, we might not match easily.
    // For MVP, enable Movies first.
  }

  return continuing;
}

@riverpod
Future<List<HomeContent>> allMoviesRail(AllMoviesRailRef ref) async {
  final movies = await ref.watch(fetchMoviesProvider.future);
  return movies.map((m) => HomeContent(
      title: m.title,
      posterUrl: m.images.firstWhere((i) => i.coverType == 'poster', orElse: () => MovieImage(coverType: 'none', url: '')).remoteUrl ?? m.images.firstOrNull?.url,
      contentId: 'movie_${m.tmdbId}',
      isMovie: true,
      originalItem: m,
      overview: m.overview,
  )).toList()..sort((a,b) => a.title.compareTo(b.title));
}

@riverpod
Future<List<HomeContent>> allSeriesRail(AllSeriesRailRef ref) async {
  final series = await ref.watch(fetchSeriesProvider.future);
  return series.map((s) => HomeContent(
      title: s.title,
      posterUrl: s.images.firstWhere((i) => i.coverType == 'poster', orElse: () => SeriesImage(coverType: 'none', url: '')).remoteUrl ?? s.images.firstOrNull?.url,
      contentId: s.tmdbId.toString(),
      isMovie: false,
      originalItem: s,
      overview: s.overview,
  )).toList()..sort((a,b) => a.title.compareTo(b.title));
}

@riverpod
Future<HomeContent?> featuredContent(FeaturedContentRef ref) async {
  // Pick one random item, preferably with a backdrop
  final recent = await ref.watch(recentlyAddedRailsProvider.future);
  if (recent.isEmpty) return null;
  
  final random = recent[Random().nextInt(recent.length)];
  return random;
}
