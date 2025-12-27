// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'series.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SeriesImpl _$$SeriesImplFromJson(Map<String, dynamic> json) => _$SeriesImpl(
      id: (json['id'] as num).toInt(),
      tvdbId: (json['tvdbId'] as num?)?.toInt() ?? 0,
      tmdbId: (json['tmdbId'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      overview: json['overview'] as String? ?? '',
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => SeriesImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      episodeCount: (json['episodeCount'] as num?)?.toInt() ?? 0,
      episodeFileCount: (json['episodeFileCount'] as num?)?.toInt() ?? 0,
      path: json['path'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$SeriesImplToJson(_$SeriesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tvdbId': instance.tvdbId,
      'tmdbId': instance.tmdbId,
      'title': instance.title,
      'overview': instance.overview,
      'images': instance.images,
      'episodeCount': instance.episodeCount,
      'episodeFileCount': instance.episodeFileCount,
      'path': instance.path,
      'status': instance.status,
    };

_$SeriesImageImpl _$$SeriesImageImplFromJson(Map<String, dynamic> json) =>
    _$SeriesImageImpl(
      coverType: json['coverType'] as String,
      url: json['url'] as String,
      remoteUrl: json['remoteUrl'] as String?,
    );

Map<String, dynamic> _$$SeriesImageImplToJson(_$SeriesImageImpl instance) =>
    <String, dynamic>{
      'coverType': instance.coverType,
      'url': instance.url,
      'remoteUrl': instance.remoteUrl,
    };
