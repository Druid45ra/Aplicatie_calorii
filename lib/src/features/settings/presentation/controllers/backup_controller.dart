import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/usecases/export_backup.dart';
import '../../domain/usecases/import_backup.dart';

final backupControllerProvider = Provider<BackupController>((ref) {
<<<<<<< ours
  return BackupController(ExportBackup(sl()), ImportBackup(sl()));
=======
  return BackupController(
    ExportBackup(sl()),
    ImportBackup(sl()),
  );
>>>>>>> theirs
});

class BackupController {
  BackupController(this.exportBackup, this.importBackup);

  final ExportBackup exportBackup;
  final ImportBackup importBackup;

<<<<<<< ours
  Future<void> exportData() {
    return exportBackup();
  }

  Future<void> importData() {
    return importBackup();
  }
=======
  Future<void> exportData() => exportBackup();

  Future<void> importData() => importBackup();
>>>>>>> theirs
}
