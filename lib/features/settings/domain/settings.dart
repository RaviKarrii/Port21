import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';
part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    @Default('') String ftpHost,
    @Default(21) int ftpPort,
    @Default('') String ftpUser,
    @Default('') String ftpPassword,
    @Default('') String radarrUrl,
    @Default('') String radarrApiKey,
    @Default('') String sonarrUrl,
    @Default('') String sonarrApiKey,
    @Default('') String remotePathPrefix,
    @Default('') String ftpPathPrefix,
    @Default('') String tmdbApiKey,

    @Default('ftp') String streamProtocol, // ftp, ftps, sftp, http
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) => _$SettingsFromJson(json);
}
