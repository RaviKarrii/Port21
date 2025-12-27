import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:isar/isar.dart';
import 'tmdb_service.dart';
import '../../settings/data/settings_repository.dart';
import '../data/library_repository.dart';
import '../data/remote/radarr_service.dart';
import '../data/remote/sonarr_service.dart';
import '../domain/movie.dart';
import '../domain/series.dart';
import '../domain/episode.dart';

part 'library_providers.g.dart';

// Access Isar instance (should be initialized in main or a core provider)
// For now we assume a provider 'isarProvider' exists or we throw
@Riverpod(keepAlive: true)
Isar isar(IsarRef ref) {
  throw UnimplementedError('Initialize Isar in main and override');
}

@riverpod
Dio dio(DioRef ref) {
  return Dio();
}

@riverpod
RadarrService? radarrService(RadarrServiceRef ref) {
  final settings = ref.watch(settingsRepositoryProvider).getSettings();
  if (settings.radarrUrl.isEmpty || settings.radarrApiKey.isEmpty) return null;
  
  return RadarrService(
    ref.watch(dioProvider),
    baseUrl: settings.radarrUrl,
    apiKey: settings.radarrApiKey,
  );
}

@riverpod
SonarrService? sonarrService(SonarrServiceRef ref) {
  final settings = ref.watch(settingsRepositoryProvider).getSettings();
  if (settings.sonarrUrl.isEmpty || settings.sonarrApiKey.isEmpty) return null;
  
  return SonarrService(
    ref.watch(dioProvider),
    baseUrl: settings.sonarrUrl,
    apiKey: settings.sonarrApiKey,
  );
}

@riverpod
TmdbService? tmdbService(TmdbServiceRef ref) {
  final settings = ref.watch(settingsRepositoryProvider).getSettings();
  if (settings.tmdbApiKey.isEmpty) return null;
  
  final service = TmdbService();
  service.init(settings.tmdbApiKey);
  return service;
}

@riverpod
LibraryRepository libraryRepository(LibraryRepositoryRef ref) {
  return LibraryRepository(
    ref.watch(isarProvider),
    ref.watch(radarrServiceProvider),
    ref.watch(sonarrServiceProvider),
  );
}

@riverpod
Future<List<Movie>> fetchMovies(FetchMoviesRef ref) async {
  return ref.watch(libraryRepositoryProvider).getMovies(forceRefresh: true);
}

@riverpod
Future<List<Series>> fetchSeries(FetchSeriesRef ref) async {
  return ref.watch(libraryRepositoryProvider).getSeries(forceRefresh: true);
}

@riverpod
Future<List<Episode>> fetchEpisodes(FetchEpisodesRef ref, int seriesId) async {
  return ref.watch(libraryRepositoryProvider).getEpisodes(seriesId);
}

@riverpod
Future<Set<int>> fetchAvailableContent(FetchAvailableContentRef ref) async {
  // We can force refresh or just rely on local DB.
  // Since "Available" implies on disk, local DB is the source of truth.
  // We don't need to hit Radarr/Sonarr for this fast check unless we want sync.
  // For DISCOVERY, local is fast and good enough.
  return ref.watch(libraryRepositoryProvider).getAvailableTmdbIds();
}
