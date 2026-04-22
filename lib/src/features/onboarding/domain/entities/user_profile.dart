import 'package:equatable/equatable.dart';

enum BiologicalSex { female, male, other }
<<<<<<< ours
<<<<<<< ours

enum ActivityLevel { sedentary, light, moderate, active, athlete }

=======
enum ActivityLevel { sedentary, light, moderate, active, athlete }
>>>>>>> theirs
=======
enum ActivityLevel { sedentary, light, moderate, active, athlete }
>>>>>>> theirs
enum GoalType { loseWeight, maintain, gainWeight }

class UserProfile extends Equatable {
  const UserProfile({
    required this.sex,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.goal,
    required this.activityLevel,
    required this.dailyCalorieTarget,
  });

  final BiologicalSex sex;
  final int age;
  final double heightCm;
  final double weightKg;
  final GoalType goal;
  final ActivityLevel activityLevel;
  final int dailyCalorieTarget;

  bool get isComplete => age > 0 && heightCm > 0 && weightKg > 0;

  UserProfile copyWith({
    BiologicalSex? sex,
    int? age,
    double? heightCm,
    double? weightKg,
    GoalType? goal,
    ActivityLevel? activityLevel,
    int? dailyCalorieTarget,
  }) {
    return UserProfile(
      sex: sex ?? this.sex,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      goal: goal ?? this.goal,
      activityLevel: activityLevel ?? this.activityLevel,
      dailyCalorieTarget: dailyCalorieTarget ?? this.dailyCalorieTarget,
    );
  }

  @override
<<<<<<< ours
<<<<<<< ours
  List<Object?> get props => [
        sex,
        age,
        heightCm,
        weightKg,
        goal,
        activityLevel,
        dailyCalorieTarget,
      ];
=======
  List<Object?> get props => [sex, age, heightCm, weightKg, goal, activityLevel, dailyCalorieTarget];
>>>>>>> theirs
=======
  List<Object?> get props => [sex, age, heightCm, weightKg, goal, activityLevel, dailyCalorieTarget];
>>>>>>> theirs
}
