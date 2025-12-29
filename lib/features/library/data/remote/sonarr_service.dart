import 'package:dio/dio.dart';
import '../../domain/series.dart';
import '../../domain/episode.dart';

class SonarrService {
  final Dio _dio;
  final String _baseUrl;
  final String _apiKey;

  SonarrService(this._dio, {required String baseUrl, required String apiKey})
      : _baseUrl = baseUrl,
        _apiKey = apiKey;

  Future<List<Series>> getSeries() async {
    try {
      final response = await _dio.get(
        '$_baseUrl/api/v3/series',
        queryParameters: {'apikey': _apiKey},
      );
      
      final List<dynamic> data = response.data;

      return data.map((json) {
         if (json['statistics'] != null) {
            json['episodeFileCount'] = json['statistics']['episodeFileCount'];
            json['episodeCount'] = json['statistics']['episodeCount'];
            // json['sizeOnDisk'] = json['statistics']['sizeOnDisk']; // Series model doesn't have sizeOnDisk yet, but good to know
         }
         return Series.fromJson(json);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Episode>> getEpisodes(int seriesId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/api/v3/episode',
        queryParameters: {
          'apikey': _apiKey,
          'seriesId': seriesId,
        //  'includeEpisodeFile': true, // Apparently Sonarr v3 requires this or returns it by default? 
        //  Actually, documentation says episodeFile is included if available usually.
        //  But let's be safe. Wait, 'episode' endpoint returns minimal info. 
        //  Maybe we need to fetch episode files separately or pass the flag?
        //  Let's try passing the flag. Common Sonarr API pattern.
        },
      );
      
      final List<dynamic> data = response.data;
      
      // We need to fetch episode files because they contain the path.
      // But fetching all episode files for a series is a separate call usually: /api/v3/episodefile?seriesId=...
      // Or we can just hope 'episodeFile' is inside 'episode' response. 
      // Checking Sonarr docs: /api/v3/episode returns EpisodeResource which has 'episodeFileId'. It does NOT contain the file struct.
      // We need to fetch /api/v3/episodefile?seriesId=X to get all files, then map them.
      
      // Fetch Episode Files
      final filesResponse = await _dio.get(
        '$_baseUrl/api/v3/episodefile',
         queryParameters: {
          'apikey': _apiKey,
          'seriesId': seriesId,
        },
      );
      final List<dynamic> filesData = filesResponse.data;
      // Map fileId -> {path, size}
      final filesMap = {
        for (var f in filesData) 
          f['id'] as int : {
             'path': f['path'] as String,
             'size': f['size'] as int? ?? 0
          }
      };

      return data.map((json) {
         // Inject path and size if file exists
         if (json['episodeFileId'] != null && json['episodeFileId'] != 0) {
            final fileId = json['episodeFileId'] as int;
            if (filesMap.containsKey(fileId)) {
               final fileInfo = filesMap[fileId]!;
               json['path'] = fileInfo['path'];
               json['sizeOnDisk'] = fileInfo['size'];
               json['hasFile'] = true;
               // print('SonarrService: Injected path ${json['path']} size ${json['sizeOnDisk']}');
            }
         }
         return Episode.fromJson(json);
      }).toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> testConnection() async {
    try {
      // Sonarr API: /api/v3/system/status
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

  Future<bool> addSeries(Map<String, dynamic> body) async {
    try {
      await _dio.post(
        '$_baseUrl/api/v3/series',
        queryParameters: {'apikey': _apiKey},
        data: body,
      );
      return true;
    } catch (e) {
      print('Sonarr Add Error: $e');
      return false;
    }
  }

  Future<List<dynamic>> lookup(String term) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/api/v3/series/lookup',
        queryParameters: {'apikey': _apiKey, 'term': term},
      );
      return response.data as List<dynamic>;
    } catch (e) {
      return [];
    }
  }
}
