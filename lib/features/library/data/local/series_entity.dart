import 'package:isar/isar.dart';

part 'series_entity.g.dart';

@collection
class SeriesEntity {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late int sonarrId;

  late String title;
  late String overview;
  String? path;
  String? status; // Added
  int tvdbId = 0; // Added
  int tmdbId = 0; // Added
  int episodeCount = 0; // Added
  int episodeFileCount = 0; // Added
  
  List<SeriesImageEntity> images = [];
}

@embedded
class SeriesImageEntity {
  late String coverType;

  late String url;
  String? remoteUrl; // Added
}
