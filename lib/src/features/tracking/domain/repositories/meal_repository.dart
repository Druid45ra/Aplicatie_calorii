import '../entities/meal_entry.dart';

abstract class MealRepository {
  Future<List<MealEntry>> getMeals();
  Future<void> saveMeals(List<MealEntry> meals);
}
