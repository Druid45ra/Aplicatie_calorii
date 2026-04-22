import '../../features/settings/domain/entities/sync_status.dart';
import 'api_config.dart';
import 'remote_sync_client.dart';

class NoopRemoteSyncClient implements RemoteSyncClient {
  const NoopRemoteSyncClient(this.config);

  final ApiConfig config;

  @override
  Future<SyncStatus> getStatus() async {
    return SyncStatus(
      mode: SyncMode.localOnly,
      state: SyncState.idle,
      lastSuccessfulSync: null,
      pendingOperations: 0,
      endpoint: config.baseUrl,
      message: 'Remote sync is not enabled yet. Local-first architecture is ready for API integration.',
    );
  }
}
