import '../entities/sync_result.dart';

abstract class RemoteSyncRepository {
  Future<SyncResult> pushLocalData();
  Future<SyncResult> pullRemoteData();
  Future<SyncResult> syncNow();
}
