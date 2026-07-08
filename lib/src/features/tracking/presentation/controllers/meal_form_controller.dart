import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/meal_entry.dart';

/// State for the meal form
class MealFormState {
  const MealFormState({
    this.name = '',
    this.calories = 0,
    this.protein = 0,
    this.carbs = 0,
    this.fat = 0,
    this.mealType = 'Breakfast',
    this.notes = '',
    this.errors = const {},
  });

  final String name;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final String mealType;
  final String notes;
  final Map<String, String> errors;

  MealFormState copyWith({
    String? name,
    int? calories,
    double? protein,
    double? carbs,
    double? fat,
    String? mealType,
    String? notes,
    Map<String, String>? errors,
  }) {
    return MealFormState(
      name: name ?? this.name,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      mealType: mealType ?? this.mealType,
      notes: notes ?? this.notes,
      errors: errors ?? this.errors,
    );
  }
}

/// Notifier for managing meal form state
class MealFormNotifier extends StateNotifier<MealFormState> {
  MealFormNotifier({MealEntry? initialMeal}) : super(const MealFormState()) {
    if (initialMeal != null) {
      state = MealFormState(
        name: initialMeal.name,
        calories: initialMeal.calories,
        protein: initialMeal.protein,
        carbs: initialMeal.carbs,
        fat: initialMeal.fat,
        mealType: initialMeal.mealType,
        notes: initialMeal.notes,
      );
    }
  }

  /// Update individual form fields
  void updateName(String value) => state = state.copyWith(name: value);
  void updateCalories(int value) => state = state.copyWith(calories: value);
  void updateProtein(double value) => state = state.copyWith(protein: value);
  void updateCarbs(double value) => state = state.copyWith(carbs: value);
  void updateFat(double value) => state = state.copyWith(fat: value);
  void updateMealType(String value) => state = state.copyWith(mealType: value);
  void updateNotes(String value) => state = state.copyWith(notes: value);

  /// Validate form and return errors map
  Map<String, String> validate() {
    final errors = <String, String>{};

    if (state.name.trim().isEmpty) {
      errors['name'] = 'Meal name is required';
    }

    if (state.calories < 0 || state.calories > 10000) {
      errors['calories'] = 'Calories must be between 0 and 10000';
    }

    if (state.protein < 0 || state.protein > 500) {
      errors['protein'] = 'Protein must be between 0 and 500g';
    }

    if (state.carbs < 0 || state.carbs > 1000) {
      errors['carbs'] = 'Carbs must be between 0 and 1000g';
    }

    if (state.fat < 0 || state.fat > 500) {
      errors['fat'] = 'Fat must be between 0 and 500g';
    }

    state = state.copyWith(errors: errors);
    return errors;
  }

  /// Reset form to initial state
  void reset() => state = const MealFormState();
}

/// Provider for meal form state
final mealFormProvider =
    StateNotifierProvider<MealFormNotifier, MealFormState>((ref) {
  return MealFormNotifier();
});
