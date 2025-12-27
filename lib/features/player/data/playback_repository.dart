import 'package:isar/isar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../player/domain/playback_position.dart';
import '../../../main.dart'; // To access Isar instance if global, or verify if provider needed

final playbackRepositoryProvider = Provider((ref) => PlaybackRepository());

class PlaybackRepository {
  Future<void> savePosition(String contentId, int position, int duration) async {
    final isar = Isar.getInstance(); 
    if (isar == null) return;
    
    final existing = await isar.playbackPositions.filter().contentIdEqualTo(contentId).findFirst();
    
    await isar.writeTxn(() async {
      final entry = existing ?? PlaybackPosition();
      entry.contentId = contentId;
      entry.positionSeconds = position;
      entry.durationSeconds = duration;
      entry.lastWatched = DateTime.now();
      await isar.playbackPositions.put(entry);
    });
  }

  Future<PlaybackPosition?> getPosition(String contentId) async {
    final isar = Isar.getInstance();
    if (isar == null) return null;
    return await isar.playbackPositions.filter().contentIdEqualTo(contentId).findFirst();
  }
  Stream<List<PlaybackPosition>> watchAllPositions() {
    final isar = Isar.getInstance();
    if (isar == null) return Stream.value([]);
    return isar.playbackPositions.where().watch(fireImmediately: true);
  }
}

final playbackPositionsProvider = StreamProvider<List<PlaybackPosition>>((ref) {
  final repo = ref.watch(playbackRepositoryProvider);
  return repo.watchAllPositions();
});
