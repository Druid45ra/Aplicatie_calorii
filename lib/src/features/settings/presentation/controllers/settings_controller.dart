import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/usecases/reset_local_data.dart';

final settingsControllerProvider = Provider<SettingsController>((ref) {
  return SettingsController(ResetLocalData(sl(), sl(), sl()));
});

class SettingsController {
  SettingsController(this.resetLocalData);

  final ResetLocalData resetLocalData;

  Future<void> resetAll() {
    return resetLocalData();
  }
}
