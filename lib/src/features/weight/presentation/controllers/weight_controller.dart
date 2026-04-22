import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/entities/weight_entry.dart';
import '../../domain/usecases/get_weight_entries.dart';
import '../../domain/usecases/save_weight_entries.dart';

<<<<<<< ours
final weightControllerProvider =
    AsyncNotifierProvider<WeightController, List<WeightEntry>>(
      WeightController.new,
    );
=======
final weightControllerProvider = AsyncNotifierProvider<WeightController, List<WeightEntry>>(WeightController.new);
>>>>>>> theirs

class WeightController extends AsyncNotifier<List<WeightEntry>> {
  late final GetWeightEntries _getEntries = GetWeightEntries(sl());
  late final SaveWeightEntries _saveEntries = SaveWeightEntries(sl());
<<<<<<< ours

  final _uuid = const Uuid();

  @override
  Future<List<WeightEntry>> build() async {
    final entries = await _getEntries();
    entries.sort((a, b) => a.date.compareTo(b.date));
    return entries;
  }

  Future<void> addEntry(double weight, DateTime date) async {
final current = [
      ...state.valueOrNull ?? await _getEntries(),
      WeightEntry(id: _uuid.v4(), weightKg: weight, date: date),
    ]..sort((a, b) => a.date.compareTo(b.date));

=======
  final _uuid = const Uuid();

  @override
  Future<List<WeightEntry>> build() => _getEntries();

  Future<void> addEntry(double weight, DateTime date) async {
    final current = [...state.valueOrNull ?? await _getEntries()]
      ..add(WeightEntry(id: _uuid.v4(), weightKg: weight, date: date))
      ..sort((a, b) => a.date.compareTo(b.date));
>>>>>>> theirs
    await _persist(current);
  }

  Future<void> removeEntry(String id) async {
<<<<<<< ours
    final current = [...state.valueOrNull ?? await _getEntries()]
      ..removeWhere((entry) => entry.id == id);

=======
    final current = [...state.valueOrNull ?? await _getEntries()]..removeWhere((entry) => entry.id == id);
>>>>>>> theirs
    await _persist(current);
  }

  Future<void> _persist(List<WeightEntry> entries) async {
    state = const AsyncLoading();
<<<<<<< ours

    state = await AsyncValue.guard(() async {
      await _saveEntries(entries);
      final reloaded = await _getEntries();
      reloaded.sort((a, b) => a.date.compareTo(b.date));
      return reloaded;
=======
    state = await AsyncValue.guard(() async {
      await _saveEntries(entries);
      return _getEntries();
>>>>>>> theirs
    });
  }
}
