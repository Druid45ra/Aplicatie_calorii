import '../../../../core/network/remote_sync_client.dart';
import '../../domain/entities/sync_status.dart';
import '../../domain/repositories/sync_repository.dart';

class SyncRepositoryImpl implements SyncRepository {
  const SyncRepositoryImpl(this.remoteSyncClient);

  final RemoteSyncClient remoteSyncClient;

  @override
  Future<SyncStatus> getStatus() => remoteSyncClient.getStatus();
}
