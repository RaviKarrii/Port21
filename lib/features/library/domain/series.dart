import 'package:freezed_annotation/freezed_annotation.dart';

part 'series.freezed.dart';
part 'series.g.dart';

@freezed
class Series with _$Series {
  const factory Series({
    required int id,
    @Default(0) int tvdbId,
    @Default(0) int tmdbId,
    required String title,
    @Default('') String overview,
    @Default([]) List<SeriesImage> images,
    @Default(0) int episodeCount,
    @Default(0) int episodeFileCount,
    String? path,
    String? status,
  }) = _Series;

  factory Series.fromJson(Map<String, dynamic> json) => _$SeriesFromJson(json);
}

@freezed
class SeriesImage with _$SeriesImage {
  const factory SeriesImage({
    required String coverType,
    required String url,
    String? remoteUrl,
  }) = _SeriesImage;

  factory SeriesImage.fromJson(Map<String, dynamic> json) => _$SeriesImageFromJson(json);
}
