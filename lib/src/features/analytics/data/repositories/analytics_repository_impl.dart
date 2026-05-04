import '../../../tracking/domain/repositories/meal_repository.dart';
import '../../../weight/domain/repositories/weight_repository.dart';
import '../../domain/entities/analytics_snapshot.dart';
import '../../domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  AnalyticsRepositoryImpl(this.mealRepository, this.weightRepository);

  final MealRepository mealRepository;
  final WeightRepository weightRepository;

  @override
  Future<AnalyticsSnapshot> getSnapshot() async {
    final meals = await mealRepository.getMeals();
    final entries = await weightRepository.getEntries();
    final averageCalories = meals.isEmpty
        ? 0.0
        : meals.fold<int>(0, (sum, meal) => sum + meal.calories) /
            meals.length;
    final averageWeight = entries.isEmpty
        ? 0.0
        : entries.fold<double>(0, (sum, item) => sum + item.weightKg) /
            entries.length;
    final weightChange = entries.length < 2
        ? 0.0
        : entries.last.weightKg - entries.first.weightKg;
    final goal = 2000;
    final adherenceDays = meals.where((meal) => meal.calories <= goal).length;
    final adherenceRate = meals.isEmpty ? 0.0 : adherenceDays / meals.length;

    return AnalyticsSnapshot(
      averageCalories: averageCalories,
      averageWeight: averageWeight,
      weightChange: weightChange,
      adherenceRate: adherenceRate,
    );
  }
}
