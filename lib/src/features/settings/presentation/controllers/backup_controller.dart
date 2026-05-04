import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/usecases/export_backup.dart';
import '../../domain/usecases/import_backup.dart';

final backupControllerProvider = Provider<BackupController>((ref) {
  return BackupController(
    ExportBackup(sl()),
    ImportBackup(sl()),
  );
});

class BackupController {
  BackupController(this.exportBackup, this.importBackup);

  final ExportBackup exportBackup;
  final ImportBackup importBackup;

  Future<void> exportData() => exportBackup();

  Future<void> importData() => importBackup();

}
