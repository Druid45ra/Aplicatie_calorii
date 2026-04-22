import '../repositories/backup_repository.dart';

class ExportBackup {
  const ExportBackup(this.repository);

  final BackupRepository repository;

<<<<<<< ours
<<<<<<< ours
  Future<void> call() {
    return repository.exportBackup();
  }
=======
  Future<void> call() => repository.exportBackup();
>>>>>>> theirs
=======
  Future<void> call() => repository.exportBackup();
>>>>>>> theirs
}
