import '../../domain/entities/meal_entry.dart';

class MealEntryModel extends MealEntry {
  const MealEntryModel({
    required super.id,
    required super.name,
    required super.calories,
    required super.protein,
    required super.carbs,
    required super.fat,
    required super.date,
    required super.mealType,
    required super.notes,
  });

<<<<<<< ours
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'date': date.toIso8601String(),
      'mealType': mealType,
      'notes': notes,
    };
  }

  factory MealEntryModel.fromMap(Map<dynamic, dynamic> map) {
    return MealEntryModel(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      calories: (map['calories'] as num?)?.toInt() ?? 0,
      protein: (map['protein'] as num?)?.toDouble() ?? 0,
      carbs: (map['carbs'] as num?)?.toDouble() ?? 0,
      fat: (map['fat'] as num?)?.toDouble() ?? 0,
      date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
      mealType: map['mealType'] as String? ?? 'Meal',
      notes: map['notes'] as String? ?? '',
    );
  }

  factory MealEntryModel.fromEntity(MealEntry entity) {
    return MealEntryModel(
      id: entity.id,
      name: entity.name,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      date: entity.date,
      mealType: entity.mealType,
      notes: entity.notes,
    );
  }
=======
  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'date': date.toIso8601String(),
        'mealType': mealType,
        'notes': notes,
      };

  factory MealEntryModel.fromMap(Map<dynamic, dynamic> map) => MealEntryModel(
        id: map['id'] as String? ?? '',
        name: map['name'] as String? ?? '',
        calories: (map['calories'] as num?)?.toInt() ?? 0,
        protein: (map['protein'] as num?)?.toDouble() ?? 0,
        carbs: (map['carbs'] as num?)?.toDouble() ?? 0,
        fat: (map['fat'] as num?)?.toDouble() ?? 0,
        date: DateTime.tryParse(map['date'] as String? ?? '') ?? DateTime.now(),
        mealType: map['mealType'] as String? ?? 'Meal',
        notes: map['notes'] as String? ?? '',
      );

  factory MealEntryModel.fromEntity(MealEntry entity) => MealEntryModel(
        id: entity.id,
        name: entity.name,
        calories: entity.calories,
        protein: entity.protein,
        carbs: entity.carbs,
        fat: entity.fat,
        date: entity.date,
        mealType: entity.mealType,
        notes: entity.notes,
      );
>>>>>>> theirs
}
