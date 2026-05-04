import '../../../../core/utils/date_utils.dart';
import '../../../onboarding/domain/repositories/profile_repository.dart';
import '../../../tracking/domain/repositories/meal_repository.dart';
import '../../../weight/domain/repositories/weight_repository.dart';
import '../../domain/entities/analytics_snapshot.dart';
import '../../domain/repositories/analytics_repository.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  AnalyticsRepositoryImpl(
    this.mealRepository,
    this.weightRepository,
    this.profileRepository,
  );

  final MealRepository mealRepository;
  final WeightRepository weightRepository;
  final ProfileRepository profileRepository;

  @override
  Future<AnalyticsSnapshot> getSnapshot() async {
    final meals = await mealRepository.getMeals();
    final entries = await weightRepository.getEntries();
    final profile = await profileRepository.getProfile();
    final averageCalories = meals.isEmpty
        ? 0.0
        : meals.fold<int>(0, (sum, meal) => sum + meal.calories) / meals.length;
    final averageWeight = entries.isEmpty
        ? 0.0
        : entries.fold<double>(0, (sum, item) => sum + item.weightKg) /
            entries.length;
    final weightChange = entries.length < 2
        ? 0.0
        : entries.last.weightKg - entries.first.weightKg;
    final goal = profile?.dailyCalorieTarget ?? 2000;
    final dailyCalories = <DateTime, int>{};
    for (final meal in meals) {
      final date = AppDateUtils.normalizeDate(meal.date);
      dailyCalories[date] = (dailyCalories[date] ?? 0) + meal.calories;
    }
    final adherenceDays = dailyCalories.values.where((calories) {
      return calories <= goal;
    }).length;
    final adherenceRate =
        dailyCalories.isEmpty ? 0.0 : adherenceDays / dailyCalories.length;

    return AnalyticsSnapshot(
      averageCalories: averageCalories,
      averageWeight: averageWeight,
      weightChange: weightChange,
      adherenceRate: adherenceRate,
    );
  }
}
