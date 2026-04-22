import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/usecases/reset_local_data.dart';

final settingsControllerProvider = Provider<SettingsController>((ref) {
<<<<<<< ours
  return SettingsController(ResetLocalData(sl(), sl(), sl()));
=======
  return SettingsController(
    ResetLocalData(
      sl(),
      sl(),
      sl(),
    ),
  );
>>>>>>> theirs
});

class SettingsController {
  SettingsController(this.resetLocalData);

  final ResetLocalData resetLocalData;

<<<<<<< ours
  Future<void> resetAll() {
    return resetLocalData();
  }
=======
  Future<void> resetAll() => resetLocalData();
>>>>>>> theirs
}
