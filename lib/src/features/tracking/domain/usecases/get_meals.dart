import '../entities/meal_entry.dart';
import '../repositories/meal_repository.dart';

class GetMeals {
  const GetMeals(this.repository);

  final MealRepository repository;

  Future<List<MealEntry>> call() => repository.getMeals();

}
