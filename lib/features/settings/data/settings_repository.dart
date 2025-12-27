import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../domain/settings.dart';

part 'settings_repository.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(SettingsRepositoryRef ref) {
  throw UnimplementedError('Initialize SharedPrefs and override this provider in main');
}

class SettingsRepository {
  final SharedPreferences _prefs;
  static const _key = 'app_settings';

  SettingsRepository(this._prefs);

  Settings getSettings() {
    final jsonParts = _prefs.getString(_key);
    if (jsonParts == null) return const Settings();
    return Settings.fromJson(jsonDecode(jsonParts));
  }

  Future<void> saveSettings(Settings settings) async {
    await _prefs.setString(_key, jsonEncode(settings.toJson()));
  }
}
