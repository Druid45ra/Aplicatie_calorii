import '../../features/settings/domain/entities/sync_status.dart';

abstract class RemoteSyncClient {
  Future<SyncStatus> getStatus();
}
