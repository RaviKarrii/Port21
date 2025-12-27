// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      ftpHost: json['ftpHost'] as String? ?? '',
      ftpPort: (json['ftpPort'] as num?)?.toInt() ?? 21,
      ftpUser: json['ftpUser'] as String? ?? '',
      ftpPassword: json['ftpPassword'] as String? ?? '',
      radarrUrl: json['radarrUrl'] as String? ?? '',
      radarrApiKey: json['radarrApiKey'] as String? ?? '',
      sonarrUrl: json['sonarrUrl'] as String? ?? '',
      sonarrApiKey: json['sonarrApiKey'] as String? ?? '',
      remotePathPrefix: json['remotePathPrefix'] as String? ?? '',
      ftpPathPrefix: json['ftpPathPrefix'] as String? ?? '',
      tmdbApiKey: json['tmdbApiKey'] as String? ?? '',
      streamProtocol: json['streamProtocol'] as String? ?? 'ftp',
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'ftpHost': instance.ftpHost,
      'ftpPort': instance.ftpPort,
      'ftpUser': instance.ftpUser,
      'ftpPassword': instance.ftpPassword,
      'radarrUrl': instance.radarrUrl,
      'radarrApiKey': instance.radarrApiKey,
      'sonarrUrl': instance.sonarrUrl,
      'sonarrApiKey': instance.sonarrApiKey,
      'remotePathPrefix': instance.remotePathPrefix,
      'ftpPathPrefix': instance.ftpPathPrefix,
      'tmdbApiKey': instance.tmdbApiKey,
      'streamProtocol': instance.streamProtocol,
    };
