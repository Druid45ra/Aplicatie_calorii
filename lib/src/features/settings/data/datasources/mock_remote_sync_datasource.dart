import '../models/sync_payload_model.dart';
import '../models/sync_result_model.dart';
import 'remote_sync_datasource.dart';

class MockRemoteSyncDataSource implements RemoteSyncDataSource {
  SyncPayloadModel? _snapshot;

  @override
  Future<SyncResultModel> push(SyncPayloadModel payload) async {
    _snapshot = payload;
    return SyncResultModel(
      success: true,
      message: 'Push completed (mock remote).',
      receivedMeals: payload.meals.length,
      receivedWeights: payload.weights.length,
      syncedAt: DateTime.now().toIso8601String(),
    );
  }

  @override
  Future<SyncPayloadModel> pull() async {
    return _snapshot ??
        SyncPayloadModel(
          profile: null,
          meals: const [],
          weights: const [],
          generatedAt: DateTime.now().toIso8601String(),
          schemaVersion: 1,
        );
  }

  @override
  Future<SyncResultModel> sync(SyncPayloadModel payload) async {
    _snapshot = payload;
    return SyncResultModel(
      success: true,
      message: 'Two-way sync completed (mock remote).',
      receivedMeals: payload.meals.length,
      receivedWeights: payload.weights.length,
      syncedAt: DateTime.now().toIso8601String(),
    );
  }
}
