import 'package:flutter/foundation.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TmdbService {
  late final TMDB _tmdb;
  bool _isInit = false;

  void init(String apiKey) {
    _tmdb = TMDB(
      ApiKeys(apiKey, 'apiReadAccessToken_is_optional_here'), 
      logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true),
    );
    _isInit = true;
  }

  bool get isReady => _isInit;

  Future<List<dynamic>> getPopularMovies() async {
    if (!_isInit) return [];
    try {
      final result = await _tmdb.v3.movies.getPopular();
      return result['results'] as List<dynamic>;
    } catch (e) {
      debugPrint('TMDB: Get Popular Movies Error: $e');
      return [];
    }
  }

  Future<List<dynamic>> getPopularSeries() async {
    if (!_isInit) return [];
    try {
      final result = await _tmdb.v3.tv.getPopular();
      return result['results'] as List<dynamic>;
    } catch (e) {
       debugPrint('TMDB: Get Popular Series Error: $e');
       return [];
    }
  }

  Future<List<dynamic>> search(String query, {bool isMovie = true}) async {
    if (!_isInit) return [];
    try {
      final Map result;
      if (isMovie) {
        result = await _tmdb.v3.search.queryMovies(query);
      } else {
        result = await _tmdb.v3.search.queryTvShows(query);
      }
      return result['results'] as List<dynamic>;
    } catch (e) {
      debugPrint('TMDB: Search Error: $e');
      return [];
    }
  }
}
