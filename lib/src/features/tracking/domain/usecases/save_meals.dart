import '../entities/meal_entry.dart';
import '../repositories/meal_repository.dart';

class SaveMeals {
  const SaveMeals(this.repository);

  final MealRepository repository;

  Future<void> call(List<MealEntry> meals) {
    return repository.saveMeals(meals);
  }
}
