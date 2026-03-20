import '../entities/weight_entry.dart';

abstract class WeightRepository {
  Future<List<WeightEntry>> getEntries();
  Future<void> saveEntries(List<WeightEntry> entries);
}
