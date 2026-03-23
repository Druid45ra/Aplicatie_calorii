abstract class BackupRepository {
  Future<void> exportBackup();
  Future<void> importBackup();
}
