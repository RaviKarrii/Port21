import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@freezed
class Episode with _$Episode {
  const factory Episode({
    required int id,
    required int seriesId,
    required int episodeFileId,
    required int seasonNumber,
    required int episodeNumber,
    String? title,
    String? overview,
    String? path,
    @Default(0) int sizeOnDisk, // Added
    @Default(false) bool hasFile,
    DateTime? airDateUtc,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);
}
