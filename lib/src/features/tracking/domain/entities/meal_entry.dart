import 'package:equatable/equatable.dart';

class MealEntry extends Equatable {
  const MealEntry({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.date,
    required this.mealType,
    required this.notes,
  });

  final String id;
  final String name;
  final int calories;
  final double protein;
  final double carbs;
  final double fat;
  final DateTime date;
  final String mealType;
  final String notes;

  MealEntry copyWith({
    String? id,
    String? name,
    int? calories,
    double? protein,
    double? carbs,
    double? fat,
    DateTime? date,
    String? mealType,
    String? notes,
  }) {
    return MealEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      date: date ?? this.date,
      mealType: mealType ?? this.mealType,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    calories,
    protein,
    carbs,
    fat,
    date,
    mealType,
    notes,
  ];
}
