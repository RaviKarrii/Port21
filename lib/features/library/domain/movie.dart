import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  const factory Movie({
    required int id,
    @Default(0) int tmdbId,
    required String title,
    @Default('') String overview,

    String? path, // remotePath
    @Default([]) List<MovieImage> images,
    @Default(false) bool hasFile,
    @Default(0) int sizeOnDisk,
    @Default(0) int runtime,
    DateTime? added,
    @Default(0) int year, // Added year
  }) = _Movie;

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}

@freezed
class MovieImage with _$MovieImage {
  const factory MovieImage({
    required String coverType,
    required String url,
    String? remoteUrl,
  }) = _MovieImage;

  factory MovieImage.fromJson(Map<String, dynamic> json) => _$MovieImageFromJson(json);
}
