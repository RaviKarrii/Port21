import 'package:isar/isar.dart';
import '../domain/movie.dart';
import '../domain/series.dart';
import 'local/movie_entity.dart';
import 'local/series_entity.dart';
import 'remote/radarr_service.dart';
import 'remote/sonarr_service.dart';
import '../domain/episode.dart';

class LibraryRepository {
  final RadarrService? _radarrService;
  final SonarrService? _sonarrService;
  final Isar _isar;

  LibraryRepository(this._isar, this._radarrService, this._sonarrService);

  // --- Movies ---

  Future<List<Movie>> getMovies({bool forceRefresh = false}) async {
    // 1. Try to load from local DB first if not forced
    if (!forceRefresh) {
      final localMovies = await _isar.movieEntitys.where().findAll();
      if (localMovies.isNotEmpty) {
        return localMovies.map(_mapEntityToMovie).toList();
      }
    }

    // 2. Fetch from API
    if (_radarrService == null) {
      // Return local if API not configured
      final localMovies = await _isar.movieEntitys.where().findAll();
      return localMovies.map(_mapEntityToMovie).toList();
    }

    try {
      final movies = await _radarrService!.getMovies();
      
      // 3. Save to DB
      await _isar.writeTxn(() async {
        // Clear all? Or upsert? Upsert is safer but for simplicity lets clear for now to remove stale
        // But clearing might be bad for large libraries. Let's do clear for phase 1.
        await _isar.movieEntitys.clear();
        final entities = movies.map(_mapMovieToEntity).toList();
        await _isar.movieEntitys.putAll(entities);
      });

      return movies;
    } catch (e) {
      // Fallback to local on error
      final localMovies = await _isar.movieEntitys.where().findAll();
      if (localMovies.isNotEmpty) {
        return localMovies.map(_mapEntityToMovie).toList();
      }
      rethrow;
    }
  }

  // --- Series ---

  Future<List<Series>> getSeries({bool forceRefresh = false}) async {
    if (!forceRefresh) {
      final localSeries = await _isar.seriesEntitys.where().findAll();
      if (localSeries.isNotEmpty) {
        return localSeries.map(_mapEntityToSeries).toList();
      }
    }

    if (_sonarrService == null) {
      final localSeries = await _isar.seriesEntitys.where().findAll();
      return localSeries.map(_mapEntityToSeries).toList();
    }

    try {
      final seriesList = await _sonarrService!.getSeries();

      await _isar.writeTxn(() async {
        await _isar.seriesEntitys.clear();
        final entities = seriesList.map(_mapSeriesToEntity).toList();
        await _isar.seriesEntitys.putAll(entities);
      });

      return seriesList;
    } catch (e) {
      final localSeries = await _isar.seriesEntitys.where().findAll();
      if (localSeries.isNotEmpty) {
        return localSeries.map(_mapEntityToSeries).toList();
      }
      rethrow;
    }
  }

  // --- Episodes ---

  Future<List<Episode>> getEpisodes(int seriesId) async {
    if (_sonarrService == null) {
      return []; // Or throw specific error
    }
    // No local caching for episodes yet in this MVP
    return _sonarrService!.getEpisodes(seriesId);
  }

  // --- Availability ---

  Future<Set<int>> getAvailableTmdbIds() async {
    final availableIds = <int>{};

    // 1. Movies (Has File, Valid TMDB ID)
    final movies = await _isar.movieEntitys
        .filter()
        .hasFileEqualTo(true)
        .and()
        .tmdbIdIsNotNull()
        .and()
        .tmdbIdGreaterThan(0)
        .findAll();
    
    for (var m in movies) {
      if (m.tmdbId != null) availableIds.add(m.tmdbId!);
    }

    // 2. Series (File Count > 0, Valid TMDB ID)
    // Note: 'status' isn't enough, we check if we have files.
    // Or should we mark monitored? User said "Available to watch".
    final series = await _isar.seriesEntitys
        .filter()
        .episodeFileCountGreaterThan(0)
        .and()
        .tmdbIdGreaterThan(0)
        .findAll();
        
    for (var s in series) {
      if (s.tmdbId != null) availableIds.add(s.tmdbId!);
    }

    return availableIds;
  }

  // --- Mappers ---

  Movie _mapEntityToMovie(MovieEntity e) {
    return Movie(
      id: e.radarrId,
      title: e.title,
      overview: e.overview,
      path: e.remotePath,
      hasFile: e.hasFile,
      sizeOnDisk: e.sizeOnDisk,
      tmdbId: e.tmdbId ?? 0, // Added with default
      images: e.images.map((i) => MovieImage(coverType: i.coverType, url: i.url, remoteUrl: i.remoteUrl)).toList(),
    );
  }

  MovieEntity _mapMovieToEntity(Movie m) {
    // Map Images
    final imageEntities = m.images.map((i) {
      final ie = MovieImageEntity();
      ie.coverType = i.coverType;
      ie.url = i.url;
      ie.remoteUrl = i.remoteUrl; // Added
      return ie;
    }).toList();

    final e = MovieEntity()
      ..radarrId = m.id
      ..title = m.title
      ..overview = m.overview
      ..remotePath = m.path
      ..hasFile = m.hasFile
      ..sizeOnDisk = m.sizeOnDisk
      ..tmdbId = m.tmdbId // Added
      ..images = imageEntities;
    return e;
  }

  Series _mapEntityToSeries(SeriesEntity e) {
    return Series(
      id: e.sonarrId,
      title: e.title,
      overview: e.overview,
      path: e.path,
      images: e.images.map((i) => SeriesImage(coverType: i.coverType, url: i.url, remoteUrl: i.remoteUrl)).toList(),
      tvdbId: e.tvdbId, // Added
      tmdbId: e.tmdbId, // Added
      status: e.status, // Added
      episodeCount: e.episodeCount, // Added
      episodeFileCount: e.episodeFileCount, // Added
    );
  }

  SeriesEntity _mapSeriesToEntity(Series s) {
    final imageEntities = s.images.map((i) {
      final ie = SeriesImageEntity();
      ie.coverType = i.coverType;
      ie.url = i.url;
      ie.remoteUrl = i.remoteUrl; // Added
      return ie;
    }).toList();

    return SeriesEntity()
      ..sonarrId = s.id
      ..title = s.title
      ..overview = s.overview
      ..path = s.path
      ..tvdbId = s.tvdbId // Added
      ..tmdbId = s.tmdbId // Added
      ..status = s.status // Added
      ..episodeCount = s.episodeCount // Added
      ..episodeFileCount = s.episodeFileCount // Added
      ..images = imageEntities;
  }
}
