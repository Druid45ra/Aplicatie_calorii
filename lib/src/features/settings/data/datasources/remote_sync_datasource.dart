<<<<<<< ours

=======
>>>>>>> theirs
import '../models/sync_payload_model.dart';
import '../models/sync_result_model.dart';

abstract class RemoteSyncDataSource {
  Future<SyncResultModel> push(SyncPayloadModel payload);
  Future<SyncPayloadModel> pull();
  Future<SyncResultModel> sync(SyncPayloadModel payload);
}
