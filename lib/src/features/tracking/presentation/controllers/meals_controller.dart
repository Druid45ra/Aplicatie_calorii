import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/meal_entry.dart';
import '../../domain/usecases/get_meals.dart';
import '../../domain/usecases/save_meals.dart';

final mealsControllerProvider =
    AsyncNotifierProvider<MealsController, List<MealEntry>>(
      MealsController.new,
    );
final selectedDateProvider = StateProvider<DateTime>(
  (ref) => AppDateUtils.normalizeDate(DateTime.now()),
);

class MealsController extends AsyncNotifier<List<MealEntry>> {
  late final GetMeals _getMeals = GetMeals(sl());
  late final SaveMeals _saveMeals = SaveMeals(sl());
  final _uuid = const Uuid();

  @override
  Future<List<MealEntry>> build() => _getMeals();

  Future<void> addOrUpdate({String? id, required MealEntry entry}) async {
    final current = [...state.valueOrNull ?? await _getMeals()];
    final index = current.indexWhere((meal) => meal.id == id);
    final resolved = entry.copyWith(id: id ?? _uuid.v4());

    if (index >= 0) {
      current[index] = resolved;
    } else {
      current.add(resolved);
    }

    await _persist(current);
  }

  Future<void> remove(String id) async {
    final current = [...state.valueOrNull ?? await _getMeals()]
      ..removeWhere((meal) => meal.id == id);
    await _persist(current);
  }

  Future<void> _persist(List<MealEntry> meals) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _saveMeals(meals);
      final reloaded = await _getMeals();
      reloaded.sort((a, b) => b.date.compareTo(a.date));
      return reloaded;
    });
  }
}
