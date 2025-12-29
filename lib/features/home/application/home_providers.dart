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

// --- AVAILABLE (LOCAL) RAILS ---

@riverpod
Future<List<HomeContent>> availableMoviesRail(AvailableMoviesRailRef ref) async {
  final movies = await ref.watch(fetchMoviesProvider.future);
  
  // Filter for downloaded only
  final available = movies.where((m) => m.hasFile).toList();
  
  // Link Progress? (Optional, maybe later)

  return available.map((m) {
     return HomeContent(
        title: m.title,
        posterUrl: m.images.firstWhere((i) => i.coverType == 'poster', orElse: () => MovieImage(coverType: 'none', url: '')).remoteUrl ?? m.images.firstOrNull?.url,
        backdropUrl: m.images.firstWhere((i) => i.coverType == 'backdrop', orElse: () => MovieImage(coverType: 'none', url: '')).remoteUrl,
        contentId: 'movie_${m.tmdbId}',
        isMovie: true,
        originalItem: m,
        overview: m.overview
     );
  }).toList();
}

@riverpod
Future<List<HomeContent>> availableSeriesRail(AvailableSeriesRailRef ref) async {
  final series = await ref.watch(fetchSeriesProvider.future);
  
  // Filter for downloaded only
  final available = series.where((s) => s.episodeFileCount > 0).toList();

  return available.map((s) {
     return HomeContent(
        title: s.title,
        posterUrl: s.images.firstWhere((i) => i.coverType == 'poster', orElse: () => SeriesImage(coverType: 'none', url: '')).remoteUrl ?? s.images.firstOrNull?.url,
        backdropUrl: s.images.firstWhere((i) => i.coverType == 'backdrop', orElse: () => SeriesImage(coverType: 'none', url: '')).remoteUrl,
        contentId: 'series_${s.tmdbId}',
        isMovie: false,
        originalItem: s,
        overview: s.overview
     );
  }).toList();
}

// --- DISCOVER (TMDB) RAILS ---

@riverpod
Future<List<HomeContent>> trendingMoviesRail(TrendingMoviesRailRef ref) async {
  final tmdb = ref.watch(tmdbServiceProvider);
  if (tmdb == null) return [];
  
  final results = await tmdb.getTrendingMovies();
  
  return results.map((m) {
     final tmdbId = m['id'] as int;
     final title = m['title'] ?? 'Unknown';
     final posterPath = m['poster_path'];
     final backdropPath = m['backdrop_path'];
     final releaseDate = m['release_date'] as String?;
     final year = releaseDate != null && releaseDate.length >= 4 ? int.tryParse(releaseDate.substring(0, 4)) ?? 0 : 0;
     
     // Construct transient Movie object for Detail Sheet fallback
     final movie = Movie(
        id: -tmdbId, 
        tmdbId: tmdbId,
        title: title,
        overview: m['overview'] ?? '',
        year: year,
        images: [
           if (posterPath != null) MovieImage(coverType: 'poster', url: '', remoteUrl: 'https://image.tmdb.org/t/p/w500$posterPath'),
           if (backdropPath != null) MovieImage(coverType: 'backdrop', url: '', remoteUrl: 'https://image.tmdb.org/t/p/original$backdropPath'),
        ]
     );

     return HomeContent(
        title: title,
        posterUrl: posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null,
        backdropUrl: backdropPath != null ? 'https://image.tmdb.org/t/p/original$backdropPath' : null,
        contentId: 'movie_$tmdbId', 
        isMovie: true,
        originalItem: movie,
        overview: m['overview']
     );
  }).toList();
}

@riverpod
Future<List<HomeContent>> trendingSeriesRail(TrendingSeriesRailRef ref) async {
  final tmdb = ref.watch(tmdbServiceProvider);
  if (tmdb == null) return [];
  
  final results = await tmdb.getTrendingSeries();
  
  return results.map((s) {
     final tmdbId = s['id'] as int;
     final title = s['name'] ?? 'Unknown'; 
     final posterPath = s['poster_path'];
     final backdropPath = s['backdrop_path'];
     
     final series = Series(
        id: -tmdbId,
        tmdbId: tmdbId,
        title: title,
        overview: s['overview'] ?? '',
        images: [
           if (posterPath != null) SeriesImage(coverType: 'poster', url: '', remoteUrl: 'https://image.tmdb.org/t/p/w500$posterPath'),
           if (backdropPath != null) SeriesImage(coverType: 'backdrop', url: '', remoteUrl: 'https://image.tmdb.org/t/p/original$backdropPath'),
        ]
     );

     return HomeContent(
        title: title,
        posterUrl: posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null,
        backdropUrl: backdropPath != null ? 'https://image.tmdb.org/t/p/original$backdropPath' : null,
        contentId: 'series_$tmdbId',
        isMovie: false,
        originalItem: series,
        overview: s['overview']
     );
  }).toList();
}

@riverpod
Future<List<HomeContent>> popularMoviesRail(PopularMoviesRailRef ref) async {
  final tmdb = ref.watch(tmdbServiceProvider);
  if (tmdb == null) return [];
  
  final results = await tmdb.getPopularMovies();
  
  return results.map((m) {
     final tmdbId = m['id'] as int;
     final title = m['title'] ?? 'Unknown';
     final posterPath = m['poster_path'];
     final releaseDate = m['release_date'] as String?;
     final year = releaseDate != null && releaseDate.length >= 4 ? int.tryParse(releaseDate.substring(0, 4)) ?? 0 : 0;
     
     final movie = Movie(
        id: -tmdbId, 
        tmdbId: tmdbId,
        title: title,
        overview: m['overview'] ?? '',
        year: year,
        images: [
           if (posterPath != null) MovieImage(coverType: 'poster', url: '', remoteUrl: 'https://image.tmdb.org/t/p/w500$posterPath'),
        ]
     );

     return HomeContent(
        title: title,
        posterUrl: posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null,
        contentId: 'movie_$tmdbId',
        isMovie: true,
        originalItem: movie,
        overview: m['overview']
     );
  }).toList();
}

@riverpod
Future<List<HomeContent>> popularSeriesRail(PopularSeriesRailRef ref) async {
   final tmdb = ref.watch(tmdbServiceProvider);
  if (tmdb == null) return [];
  
  final results = await tmdb.getPopularSeries();
  
  return results.map((s) {
     final tmdbId = s['id'] as int;
     final title = s['name'] ?? 'Unknown';
     final posterPath = s['poster_path'];
     
     final series = Series(
        id: -tmdbId,
        tmdbId: tmdbId,
        title: title,
        overview: s['overview'] ?? '',
        images: [
           if (posterPath != null) SeriesImage(coverType: 'poster', url: '', remoteUrl: 'https://image.tmdb.org/t/p/w500$posterPath'),
        ]
     );

     return HomeContent(
        title: title,
        posterUrl: posterPath != null ? 'https://image.tmdb.org/t/p/w500$posterPath' : null,
        contentId: 'series_$tmdbId',
        isMovie: false,
        originalItem: series,
        overview: s['overview']
     );
  }).toList();
}

// --- UTILS ---

@riverpod
Future<HomeContent?> featuredContent(FeaturedContentRef ref, bool isMovie) async {
  // Prefer Available content for Feature?
  // Or Trending? 
  // Let's mix. Try available first.
  if (isMovie) {
     final avail = await ref.watch(availableMoviesRailProvider.future);
     if (avail.isNotEmpty) {
        return avail[Random().nextInt(avail.length)];
     }
     final trend = await ref.watch(trendingMoviesRailProvider.future);
     if (trend.isNotEmpty) return trend.first;
  } else {
     final avail = await ref.watch(availableSeriesRailProvider.future);
     if (avail.isNotEmpty) {
        return avail[Random().nextInt(avail.length)];
     }
     final trend = await ref.watch(trendingSeriesRailProvider.future);
     if (trend.isNotEmpty) return trend.first;
  }
  return null;
}

@riverpod
Future<List<HomeContent>> continueWatchingRail(ContinueWatchingRailRef ref) async {
  final positions = ref.watch(playbackPositionsProvider).valueOrNull ?? [];
  if (positions.isEmpty) return [];

  final movies = await ref.watch(fetchMoviesProvider.future);
  // final series = await ref.watch(fetchSeriesProvider.future); // TODO: Series matching
  
  final continuing = <HomeContent>[];
  
  for (var p in positions) {
    if (p.positionSeconds < 60) continue; 
    if (p.positionSeconds >= p.durationSeconds * 0.95) continue; 

    // Match Local Movie
    try {
      final m = movies.firstWhere((m) => 'movie_${m.tmdbId}' == p.contentId);
      continuing.add(HomeContent(
        title: m.title,
        posterUrl: m.images.firstWhere((i) => i.coverType == 'poster', orElse: () => MovieImage(coverType: 'none', url: '')).remoteUrl,
        backdropUrl: m.images.firstWhere((i) => i.coverType == 'backdrop', orElse: () => MovieImage(coverType: 'none', url: '')).remoteUrl,
        contentId: p.contentId,
        isMovie: true,
        originalItem: m,
        progress: p.durationSeconds > 0 ? p.positionSeconds / p.durationSeconds : 0.0,
      ));
      continue;
    } catch (_) {}
  }

  return continuing;
}
