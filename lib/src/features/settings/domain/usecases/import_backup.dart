import '../repositories/backup_repository.dart';

class ImportBackup {
  const ImportBackup(this.repository);

  final BackupRepository repository;

<<<<<<< ours
  Future<void> call() {
    return repository.importBackup();
  }
=======
  Future<void> call() => repository.importBackup();
>>>>>>> theirs
}
