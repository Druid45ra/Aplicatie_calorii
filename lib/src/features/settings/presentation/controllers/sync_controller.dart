import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/entities/sync_status.dart';
import '../../domain/usecases/get_sync_status.dart';

final syncStatusProvider = FutureProvider<SyncStatus>((ref) {
  return GetSyncStatus(sl())();
});
