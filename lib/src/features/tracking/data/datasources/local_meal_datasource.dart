import 'package:hive/hive.dart';

import '../models/meal_entry_model.dart';

class LocalMealDataSource {
  LocalMealDataSource(this.box);

  final Box<dynamic> box;
  static const _key = 'meal_entries';

  Future<List<MealEntryModel>> getMeals() async {
    final raw = box.get(_key, defaultValue: <dynamic>[]);
<<<<<<< ours

    if (raw is List) {
      return raw.whereType<Map>().map(MealEntryModel.fromMap).toList();
    }

=======
    if (raw is List) {
      return raw.whereType<Map>().map(MealEntryModel.fromMap).toList();
    }
>>>>>>> theirs
    return const [];
  }

  Future<void> saveMeals(List<MealEntryModel> meals) async {
    await box.put(_key, meals.map((meal) => meal.toMap()).toList());
  }

<<<<<<< ours
  Future<void> clearMeals() async {
    await box.delete(_key);
  }
=======
  Future<void> clearMeals() => box.delete(_key);
>>>>>>> theirs
}
