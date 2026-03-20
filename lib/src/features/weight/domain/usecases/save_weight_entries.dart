import '../entities/weight_entry.dart';
import '../repositories/weight_repository.dart';

class SaveWeightEntries {
  const SaveWeightEntries(this.repository);

  final WeightRepository repository;

  Future<void> call(List<WeightEntry> entries) {
    return repository.saveEntries(entries);
  }
}
