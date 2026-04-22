import '../../domain/entities/weight_entry.dart';
import '../../domain/repositories/weight_repository.dart';
import '../datasources/local_weight_datasource.dart';
import '../models/weight_entry_model.dart';

class WeightRepositoryImpl implements WeightRepository {
  WeightRepositoryImpl(this.localDataSource);

  final LocalWeightDataSource localDataSource;

  @override
<<<<<<< ours
  Future<List<WeightEntry>> getEntries() {
    return localDataSource.getEntries();
  }

  @override
  Future<void> saveEntries(List<WeightEntry> entries) {
    return localDataSource.saveEntries(
      entries.map(WeightEntryModel.fromEntity).toList(),
    );
  }

  @override
  Future<void> clearEntries() {
    return localDataSource.clearEntries();
  }
=======
  Future<List<WeightEntry>> getEntries() => localDataSource.getEntries();

  @override
  Future<void> saveEntries(List<WeightEntry> entries) {
    return localDataSource.saveEntries(entries.map(WeightEntryModel.fromEntity).toList());
  }

  @override
  Future<void> clearEntries() => localDataSource.clearEntries();
>>>>>>> theirs
}
