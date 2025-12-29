import 'package:dio/dio.dart';
import '../../domain/movie.dart';

class RadarrService {
  final Dio _dio;
  final String _baseUrl;
  final String _apiKey;

  RadarrService(this._dio, {required String baseUrl, required String apiKey})
      : _baseUrl = baseUrl,
        _apiKey = apiKey;

  Future<List<Movie>> getMovies() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/api/v3/movie',
        queryParameters: {'apikey': _apiKey},
      );
      
      final List<dynamic> data = response.data;
      
      // Fix: Overwrite folder path with actual file path if available
      for (var json in data) {
         if (json['movieFile'] != null && json['movieFile']['path'] != null) {
            json['path'] = json['movieFile']['path'];
            json['hasFile'] = true;
            print('RadarrService: Overwrote path with ${json['path']}'); 
         } else {
            print('RadarrService: No movieFile for ${json['title']}');
         }
      }

      return data.map((json) => Movie.fromJson(json)).toList();
    } catch (e) {
      // In a real app we would throw a specific Failure
      rethrow;
    }
  }

  Future<bool> testConnection() async {
    try {
      // Try fetching system status, or just a small query
      // Radarr API: /api/v3/system/status
      final response = await _dio.get(
        '$_baseUrl/api/v3/system/status',
        queryParameters: {'apikey': _apiKey},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
  Future<List<dynamic>> getRootFolders() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/api/v3/rootfolder',
        queryParameters: {'apikey': _apiKey},
      );
      return response.data as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  Future<List<dynamic>> getQualityProfiles() async {
     try {
      final response = await _dio.get(
        '$_baseUrl/api/v3/qualityprofile',
        queryParameters: {'apikey': _apiKey},
      );
      return response.data as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  Future<bool> addMovie(Map<String, dynamic> body) async {
    try {
      await _dio.post(
        '$_baseUrl/api/v3/movie',
        queryParameters: {'apikey': _apiKey},
        data: body,
      );
      return true;
    } catch (e) {
      print('Radarr Add Error: $e');
      return false;
    }
  }
}
