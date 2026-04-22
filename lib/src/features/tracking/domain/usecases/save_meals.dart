import '../entities/meal_entry.dart';
import '../repositories/meal_repository.dart';

class SaveMeals {
  const SaveMeals(this.repository);

  final MealRepository repository;

<<<<<<< ours
<<<<<<< ours
  Future<void> call(List<MealEntry> meals) {
    return repository.saveMeals(meals);
  }
=======
  Future<void> call(List<MealEntry> meals) => repository.saveMeals(meals);
>>>>>>> theirs
=======
  Future<void> call(List<MealEntry> meals) => repository.saveMeals(meals);
>>>>>>> theirs
}
