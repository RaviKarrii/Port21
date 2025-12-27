// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$EpisodeImpl _$$EpisodeImplFromJson(Map<String, dynamic> json) =>
    _$EpisodeImpl(
      id: (json['id'] as num).toInt(),
      seriesId: (json['seriesId'] as num).toInt(),
      episodeFileId: (json['episodeFileId'] as num).toInt(),
      seasonNumber: (json['seasonNumber'] as num).toInt(),
      episodeNumber: (json['episodeNumber'] as num).toInt(),
      title: json['title'] as String?,
      overview: json['overview'] as String?,
      path: json['path'] as String?,
      sizeOnDisk: (json['sizeOnDisk'] as num?)?.toInt() ?? 0,
      hasFile: json['hasFile'] as bool? ?? false,
      airDateUtc: json['airDateUtc'] == null
          ? null
          : DateTime.parse(json['airDateUtc'] as String),
    );

Map<String, dynamic> _$$EpisodeImplToJson(_$EpisodeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'seriesId': instance.seriesId,
      'episodeFileId': instance.episodeFileId,
      'seasonNumber': instance.seasonNumber,
      'episodeNumber': instance.episodeNumber,
      'title': instance.title,
      'overview': instance.overview,
      'path': instance.path,
      'sizeOnDisk': instance.sizeOnDisk,
      'hasFile': instance.hasFile,
      'airDateUtc': instance.airDateUtc?.toIso8601String(),
    };
