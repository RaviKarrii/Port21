import 'package:isar/isar.dart';

part 'movie_entity.g.dart';

@collection
class MovieEntity {
  Id id = Isar.autoIncrement; // local ID

  @Index(unique: true, replace: true)
  late int radarrId;

  late int? tmdbId; // Added
  late String title;
  late String overview;
  String? remotePath;
  bool hasFile = false;
  int sizeOnDisk = 0;
  
  // Storing simple list of images as JSON string or embedded object is easier, 
  // but for simplicity we will store just the poster url here or use embedded.
  // Using embedded for robustness.
  List<MovieImageEntity> images = [];
}

@embedded
class MovieImageEntity {
  late String coverType;

  late String url;
  String? remoteUrl; // Added
}
