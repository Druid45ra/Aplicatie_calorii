import 'package:flutter_test/flutter_test.dart';

import 'package:aplicatie_calorii/src/features/analytics/data/repositories/analytics_repository_impl.dart';
import 'package:aplicatie_calorii/src/features/onboarding/domain/entities/user_profile.dart';
import 'package:aplicatie_calorii/src/features/onboarding/domain/repositories/profile_repository.dart';
import 'package:aplicatie_calorii/src/features/tracking/domain/entities/meal_entry.dart';
import 'package:aplicatie_calorii/src/features/tracking/domain/repositories/meal_repository.dart';
import 'package:aplicatie_calorii/src/features/weight/domain/entities/weight_entry.dart';
import 'package:aplicatie_calorii/src/features/weight/domain/repositories/weight_repository.dart';

void main() {
  test('calculates adherence by daily total against profile target', () async {
    final repository = AnalyticsRepositoryImpl(
      _MealRepository([
        _meal(id: '1', calories: 900, date: DateTime(2026, 5, 1, 8)),
        _meal(id: '2', calories: 900, date: DateTime(2026, 5, 1, 18)),
        _meal(id: '3', calories: 2200, date: DateTime(2026, 5, 2, 12)),
      ]),
      _WeightRepository([
        WeightEntry(id: 'w1', weightKg: 80, date: DateTime(2026, 5, 1)),
        WeightEntry(id: 'w2', weightKg: 79, date: DateTime(2026, 5, 2)),
      ]),
      _ProfileRepository(
        const UserProfile(
          sex: BiologicalSex.other,
          age: 30,
          heightCm: 175,
          weightKg: 80,
          goal: GoalType.maintain,
          activityLevel: ActivityLevel.moderate,
          dailyCalorieTarget: 2000,
        ),
      ),
    );

    final snapshot = await repository.getSnapshot();

    expect(snapshot.averageCalories, closeTo(1333.33, 0.01));
    expect(snapshot.averageWeight, 79.5);
    expect(snapshot.weightChange, -1);
    expect(snapshot.adherenceRate, 0.5);
  });
}

MealEntry _meal({
  required String id,
  required int calories,
  required DateTime date,
}) {
  return MealEntry(
    id: id,
    name: 'Meal $id',
    calories: calories,
    protein: 20,
    carbs: 30,
    fat: 10,
    date: date,
    mealType: 'Meal',
    notes: '',
  );
}

class _MealRepository implements MealRepository {
  _MealRepository(this.meals);

  final List<MealEntry> meals;

  @override
  Future<void> clearMeals() async {}

  @override
  Future<List<MealEntry>> getMeals() async => meals;

  @override
  Future<void> saveMeals(List<MealEntry> meals) async {}
}

class _WeightRepository implements WeightRepository {
  _WeightRepository(this.entries);

  final List<WeightEntry> entries;

  @override
  Future<void> clearEntries() async {}

  @override
  Future<List<WeightEntry>> getEntries() async => entries;

  @override
  Future<void> saveEntries(List<WeightEntry> entries) async {}
}

class _ProfileRepository implements ProfileRepository {
  _ProfileRepository(this.profile);

  final UserProfile? profile;

  @override
  Future<void> clearProfile() async {}

  @override
  Future<UserProfile?> getProfile() async => profile;

  @override
  Future<void> saveProfile(UserProfile profile) async {}
}
