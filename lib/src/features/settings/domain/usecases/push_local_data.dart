import '../entities/sync_result.dart';
import '../repositories/remote_sync_repository.dart';

class PushLocalData {
  const PushLocalData(this.repository);

  final RemoteSyncRepository repository;

  Future<SyncResult> call() => repository.pushLocalData();
}
