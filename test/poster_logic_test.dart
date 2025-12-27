
import 'package:flutter_test/flutter_test.dart';

// Copy of the logic to verify the algorithm
String buildUrl(String baseUrl, String urlPath, String apiKey) {
    // 1. Clean Base URL: Remove trailing slash
    String cleanBase = baseUrl;
    if (cleanBase.endsWith('/')) {
      cleanBase = cleanBase.substring(0, cleanBase.length - 1);
    }
    
    // 2. Strip '/api/v3' or '/api' suffix if user accidentally included it
    // Radarr images are served from root/MediaCover, not root/api/v3/MediaCover
    final apiPattern = RegExp(r'\/api(\/v\d+)?$');
    if (apiPattern.hasMatch(cleanBase)) {
       cleanBase = cleanBase.replaceAll(apiPattern, '');
    }

    // 3. Clean URL Path: Ensure leading slash
    if (!urlPath.startsWith('/')) {
        urlPath = '/$urlPath';
    }
    
    final fullUrl = '$cleanBase$urlPath?apikey=$apiKey';
    return fullUrl;
}

void main() {
  group('Poster URL Logic', () {
    const apiKey = 'TEST_KEY';
    const posterPath = '/MediaCover/10/poster.jpg';
    const posterPathNoSlash = 'MediaCover/10/poster.jpg';

    test('Standard URL (Root)', () {
       const baseUrl = 'http://host:7878';
       final result = buildUrl(baseUrl, posterPath, apiKey);
       expect(result, 'http://host:7878/MediaCover/10/poster.jpg?apikey=TEST_KEY');
    });

    test('Standard URL with Trailing Slash', () {
       const baseUrl = 'http://host:7878/';
       final result = buildUrl(baseUrl, posterPath, apiKey);
       expect(result, 'http://host:7878/MediaCover/10/poster.jpg?apikey=TEST_KEY');
    });

    test('URL with /api/v3 (User Mistake)', () {
       const baseUrl = 'http://host:7878/api/v3';
       final result = buildUrl(baseUrl, posterPath, apiKey);
       expect(result, 'http://host:7878/MediaCover/10/poster.jpg?apikey=TEST_KEY');
    });

    test('URL with /api (Generic)', () {
       const baseUrl = 'http://host:7878/api';
       final result = buildUrl(baseUrl, posterPath, apiKey);
       expect(result, 'http://host:7878/MediaCover/10/poster.jpg?apikey=TEST_KEY');
    });

    test('URL with /radarr/api/v3 (Reverse Proxy + Mistake)', () {
       const baseUrl = 'http://host:7878/radarr/api/v3';
       final result = buildUrl(baseUrl, posterPath, apiKey);
       expect(result, 'http://host:7878/radarr/MediaCover/10/poster.jpg?apikey=TEST_KEY');
    });
    
    test('Poster Path without leading slash', () {
       const baseUrl = 'http://host:7878';
       final result = buildUrl(baseUrl, posterPathNoSlash, apiKey);
       expect(result, 'http://host:7878/MediaCover/10/poster.jpg?apikey=TEST_KEY');
    });
  });
}
