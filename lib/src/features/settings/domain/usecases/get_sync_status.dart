import '../entities/sync_status.dart';
import '../repositories/sync_repository.dart';

class GetSyncStatus {
  const GetSyncStatus(this.repository);

  final SyncRepository repository;

  Future<SyncStatus> call() => repository.getStatus();
}
