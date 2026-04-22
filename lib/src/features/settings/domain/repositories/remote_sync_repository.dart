<<<<<<< ours
class SyncResult {
  const SyncResult({
    required this.success,
    required this.message,
    required this.receivedMeals,
    required this.receivedWeights,
    required this.syncedAt,
  });

  final bool success;
  final String message;
  final int receivedMeals;
  final int receivedWeights;
  final DateTime? syncedAt;
=======
import '../entities/sync_result.dart';

abstract class RemoteSyncRepository {
  Future<SyncResult> pushLocalData();
  Future<SyncResult> pullRemoteData();
  Future<SyncResult> syncNow();
>>>>>>> theirs
}
