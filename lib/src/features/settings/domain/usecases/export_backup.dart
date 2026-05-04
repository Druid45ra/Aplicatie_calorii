import '../repositories/backup_repository.dart';

class ExportBackup {
  const ExportBackup(this.repository);

  final BackupRepository repository;

  Future<void> call() => repository.exportBackup();

}
