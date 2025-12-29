// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MovieImpl _$$MovieImplFromJson(Map<String, dynamic> json) => _$MovieImpl(
      id: (json['id'] as num).toInt(),
      tmdbId: (json['tmdbId'] as num?)?.toInt() ?? 0,
      title: json['title'] as String,
      overview: json['overview'] as String? ?? '',
      path: json['path'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => MovieImage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hasFile: json['hasFile'] as bool? ?? false,
      sizeOnDisk: (json['sizeOnDisk'] as num?)?.toInt() ?? 0,
      runtime: (json['runtime'] as num?)?.toInt() ?? 0,
      added: json['added'] == null
          ? null
          : DateTime.parse(json['added'] as String),
      year: (json['year'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$MovieImplToJson(_$MovieImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tmdbId': instance.tmdbId,
      'title': instance.title,
      'overview': instance.overview,
      'path': instance.path,
      'images': instance.images,
      'hasFile': instance.hasFile,
      'sizeOnDisk': instance.sizeOnDisk,
      'runtime': instance.runtime,
      'added': instance.added?.toIso8601String(),
      'year': instance.year,
    };

_$MovieImageImpl _$$MovieImageImplFromJson(Map<String, dynamic> json) =>
    _$MovieImageImpl(
      coverType: json['coverType'] as String,
      url: json['url'] as String,
      remoteUrl: json['remoteUrl'] as String?,
    );

Map<String, dynamic> _$$MovieImageImplToJson(_$MovieImageImpl instance) =>
    <String, dynamic>{
      'coverType': instance.coverType,
      'url': instance.url,
      'remoteUrl': instance.remoteUrl,
    };
