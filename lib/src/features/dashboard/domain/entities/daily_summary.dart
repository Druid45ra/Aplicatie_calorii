import 'package:equatable/equatable.dart';

class DailySummary extends Equatable {
  const DailySummary({
    required this.consumedCalories,
    required this.remainingCalories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.mealCount,
    required this.goalCalories,
  });

  final int consumedCalories;
  final int remainingCalories;
  final double protein;
  final double carbs;
  final double fat;
  final int mealCount;
  final int goalCalories;

  @override
<<<<<<< ours
<<<<<<< ours
  List<Object?> get props => [
        consumedCalories,
        remainingCalories,
        protein,
        carbs,
        fat,
        mealCount,
        goalCalories,
      ];
=======
  List<Object?> get props => [consumedCalories, remainingCalories, protein, carbs, fat, mealCount, goalCalories];
>>>>>>> theirs
=======
  List<Object?> get props => [consumedCalories, remainingCalories, protein, carbs, fat, mealCount, goalCalories];
>>>>>>> theirs
}
