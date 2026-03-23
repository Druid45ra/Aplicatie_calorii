import '../repositories/backup_repository.dart';

class ImportBackup {
  const ImportBackup(this.repository);

  final BackupRepository repository;

  Future<void> call() {
    return repository.importBackup();
  }
}
