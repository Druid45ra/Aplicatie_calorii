import '../entities/weight_entry.dart';
import '../repositories/weight_repository.dart';

class GetWeightEntries {
  const GetWeightEntries(this.repository);

  final WeightRepository repository;

  Future<List<WeightEntry>> call() {
    return repository.getEntries();
  }
}
