
import 'package:port21/features/library/domain/movie.dart';
import 'package:port21/features/library/domain/series.dart';

class PosterHelper {
  static String? getMoviePosterUrl(Movie movie, String baseUrl, String apiKey) {
    if (baseUrl.isEmpty || apiKey.isEmpty) return null;
    
    final poster = movie.images.firstWhere(
      (img) => img.coverType.toLowerCase() == 'poster',
      orElse: () => const MovieImage(coverType: '', url: ''),
    );
    
    // Prioritize Remote URL if available (bypassing local auth issues)
    if (poster.remoteUrl != null && poster.remoteUrl!.isNotEmpty) {
      return poster.remoteUrl;
    }

    if (poster.url.isNotEmpty) {
      return _buildUrl(baseUrl, poster.url, apiKey);
    }
    return null;
  }

  static String? getSeriesPosterUrl(Series series, String baseUrl, String apiKey) {
    if (baseUrl.isEmpty || apiKey.isEmpty) return null;

    final poster = series.images.firstWhere(
      (img) => img.coverType.toLowerCase() == 'poster',
      orElse: () => const SeriesImage(coverType: '', url: ''),
    );

    // Prioritize Remote URL if available
    if (poster.remoteUrl != null && poster.remoteUrl!.isNotEmpty) {
      return poster.remoteUrl;
    }

    if (poster.url.isNotEmpty) {
      return _buildUrl(baseUrl, poster.url, apiKey);
    }
    return null;
  }

  static String _buildUrl(String baseUrl, String urlPath, String apiKey) {
    try {
      // Robust URL construction using Uri
      // 1. Strip potential API suffix from base so we resolve against the root of the app
      String cleanBase = baseUrl;
      final apiPattern = RegExp(r'\/api(\/v\d+)?$');
      if (apiPattern.hasMatch(cleanBase)) {
         cleanBase = cleanBase.replaceAll(apiPattern, '');
      }
      
      // 2. Parse Base URI
      final baseUri = Uri.parse(cleanBase);
      
      // 3. Resolve urlPath (which might be absolute /radarr/MediaCover... or relative MediaCover...)
      // resolving an absolute path string against a base URI replaces the path.
      // E.g. http://host/radarr resolve /radarr/image -> http://host/radarr/image
      // E.g. http://host/radarr resolve /image -> http://host/image
      Uri resolvedUri = baseUri.resolve(urlPath);
      
      // Edge Case: If urlPath was relative but didn't match the Base Path structure, 
      // we might want to ensure we didn't lose the Base Path if user set one.
      // But standard Radarr behavior involves urlPath being fully qualified with URL Base.
      // So standard resolve is usually correct.
      
      // 4. Append API Key
      // We can't just use .replace(queryParameters:...) because valid URL chars might be encoded differently
      // Simple string append is safest for this specific param if no others exist.
      // But let's check if query exists.
      
      final separator = resolvedUri.query.isEmpty ? '?' : '&';
      return '${resolvedUri.toString()}$separator''apikey=$apiKey';
      
    } catch (e) {
      print("POSTER HELPER ERROR: $e");
      return '$baseUrl$urlPath?apikey=$apiKey'; // Fallback
    }
  }
}
