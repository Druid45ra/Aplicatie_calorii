import '../entities/weight_entry.dart';
import '../repositories/weight_repository.dart';

class GetWeightEntries {
  const GetWeightEntries(this.repository);

  final WeightRepository repository;

<<<<<<< ours
<<<<<<< ours
  Future<List<WeightEntry>> call() {
    return repository.getEntries();
  }
=======
  Future<List<WeightEntry>> call() => repository.getEntries();
>>>>>>> theirs
=======
  Future<List<WeightEntry>> call() => repository.getEntries();
>>>>>>> theirs
}
