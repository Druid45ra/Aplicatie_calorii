import '../../domain/entities/meal_entry.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/local_meal_datasource.dart';
import '../models/meal_entry_model.dart';

class MealRepositoryImpl implements MealRepository {
  MealRepositoryImpl(this.localDataSource);

  final LocalMealDataSource localDataSource;

  @override
<<<<<<< ours
<<<<<<< ours
  Future<List<MealEntry>> getMeals() {
    return localDataSource.getMeals();
  }

  @override
  Future<void> saveMeals(List<MealEntry> meals) {
    return localDataSource.saveMeals(
      meals.map(MealEntryModel.fromEntity).toList(),
    );
  }

  @override
  Future<void> clearMeals() {
    return localDataSource.clearMeals();
  }
=======
=======
>>>>>>> theirs
  Future<List<MealEntry>> getMeals() => localDataSource.getMeals();

  @override
  Future<void> saveMeals(List<MealEntry> meals) {
    return localDataSource.saveMeals(meals.map(MealEntryModel.fromEntity).toList());
  }

  @override
  Future<void> clearMeals() => localDataSource.clearMeals();
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
}
