import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/entities/sync_result.dart';
import '../../domain/usecases/pull_remote_data.dart';
import '../../domain/usecases/push_local_data.dart';
import '../../domain/usecases/sync_now.dart';

final remoteSyncControllerProvider =
    AsyncNotifierProvider<RemoteSyncController, SyncResult?>(RemoteSyncController.new);

class RemoteSyncController extends AsyncNotifier<SyncResult?> {
  late final PushLocalData _pushLocalData = PushLocalData(sl());
  late final PullRemoteData _pullRemoteData = PullRemoteData(sl());
  late final SyncNow _syncNow = SyncNow(sl());

  @override
  Future<SyncResult?> build() async {
    return null;
  }

  Future<void> push() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_pushLocalData.call);
  }

  Future<void> pull() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_pullRemoteData.call);
  }

  Future<void> syncNow() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_syncNow.call);
  }
}
