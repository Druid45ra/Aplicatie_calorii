import '../entities/sync_result.dart';
import '../repositories/remote_sync_repository.dart';

class PullRemoteData {
  const PullRemoteData(this.repository);

  final RemoteSyncRepository repository;

  Future<SyncResult> call() => repository.pullRemoteData();
}
