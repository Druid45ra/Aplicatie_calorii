import '../entities/sync_status.dart';

abstract class SyncRepository {
  Future<SyncStatus> getStatus();
}
