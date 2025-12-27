import 'package:isar/isar.dart';

part 'playback_position.g.dart';

@collection
class PlaybackPosition {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String contentId; // Use path or tmdbId unique identifier

  int positionSeconds = 0;
  int durationSeconds = 0;
  
  late DateTime lastWatched;
  
  // 0.0 to 1.0
  double get progress => durationSeconds > 0 ? positionSeconds / durationSeconds : 0.0;
}
