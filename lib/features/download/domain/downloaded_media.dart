import 'package:isar/isar.dart';

part 'downloaded_media.g.dart';

@collection
class DownloadedMedia {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String contentId;

  late String title;
  
  late String path;
  
  late String streamUrl;
  
  late DateTime downloadedAt;
  
  late String status; // 'downloading', 'completed', 'failed'
}
