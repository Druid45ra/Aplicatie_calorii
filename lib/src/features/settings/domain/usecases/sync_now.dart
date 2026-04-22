import '../entities/sync_result.dart';
import '../repositories/remote_sync_repository.dart';

class SyncNow {
  const SyncNow(this.repository);

  final RemoteSyncRepository repository;

  Future<SyncResult> call() => repository.syncNow();
}
