import '../../../tracking/domain/entities/meal_entry.dart';

class RemoteMealEntryDto {
  const RemoteMealEntryDto({
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
  final String date;
  final String mealType;
  final String notes;

  factory RemoteMealEntryDto.fromEntity(MealEntry entity) {
    return RemoteMealEntryDto(
      id: entity.id,
      name: entity.name,
      calories: entity.calories,
      protein: entity.protein,
      carbs: entity.carbs,
      fat: entity.fat,
      date: entity.date.toIso8601String(),
      mealType: entity.mealType,
      notes: entity.notes,
    );
  }

  MealEntry toEntity() {
    return MealEntry(
      id: id,
      name: name,
      calories: calories,
      protein: protein,
      carbs: carbs,
      fat: fat,
      date: DateTime.tryParse(date) ?? DateTime.now(),
      mealType: mealType,
      notes: notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'date': date,
      'mealType': mealType,
      'notes': notes,
    };
  }

  factory RemoteMealEntryDto.fromMap(Map<String, dynamic> map) {
    return RemoteMealEntryDto(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      calories: (map['calories'] as num?)?.toInt() ?? 0,
      protein: (map['protein'] as num?)?.toDouble() ?? 0,
      carbs: (map['carbs'] as num?)?.toDouble() ?? 0,
      fat: (map['fat'] as num?)?.toDouble() ?? 0,
      date: map['date'] as String? ?? '',
      mealType: map['mealType'] as String? ?? 'Meal',
      notes: map['notes'] as String? ?? '',
    );
  }
}
