import '../../../../core/utils/date_utils.dart';
import '../../../onboarding/domain/repositories/profile_repository.dart';
import '../../../tracking/domain/repositories/meal_repository.dart';
import '../../domain/entities/daily_summary.dart';
import '../../domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl(this.profileRepository, this.mealRepository);

  final ProfileRepository profileRepository;
  final MealRepository mealRepository;

  @override
  Future<DailySummary> getDailySummary(DateTime date) async {
    final profile = await profileRepository.getProfile();
    final meals = await mealRepository.getMeals();

    final todayMeals = meals
        .where((meal) => AppDateUtils.isSameDay(meal.date, date))
        .toList();

    final consumed = todayMeals.fold<int>(
      0,
      (sum, meal) => sum + meal.calories,
    );

    final protein = todayMeals.fold<double>(
      0,
      (sum, meal) => sum + meal.protein,
    );

    final carbs = todayMeals.fold<double>(0, (sum, meal) => sum + meal.carbs);

    final fat = todayMeals.fold<double>(0, (sum, meal) => sum + meal.fat);

    final goal = profile?.dailyCalorieTarget ?? 2000;

    return DailySummary(
      consumedCalories: consumed,
      remainingCalories: goal - consumed,
      protein: protein,
      carbs: carbs,
      fat: fat,
      mealCount: todayMeals.length,
      goalCalories: goal,
    );
  }
}
