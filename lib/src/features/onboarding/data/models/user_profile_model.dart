import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    required super.sex,
    required super.age,
    required super.heightCm,
    required super.weightKg,
    required super.goal,
    required super.activityLevel,
    required super.dailyCalorieTarget,
  });

  factory UserProfileModel.fromMap(Map<dynamic, dynamic> map) {
    return UserProfileModel(
      sex: BiologicalSex.values.byName((map['sex'] as String?) ?? 'other'),
      age: (map['age'] as num?)?.toInt() ?? 0,
      heightCm: (map['heightCm'] as num?)?.toDouble() ?? 0,
      weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
      goal: GoalType.values.byName((map['goal'] as String?) ?? 'maintain'),
      activityLevel: ActivityLevel.values.byName(
        (map['activityLevel'] as String?) ?? 'moderate',
      ),
      dailyCalorieTarget: (map['dailyCalorieTarget'] as num?)?.toInt() ?? 2000,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sex': sex.name,
      'age': age,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'goal': goal.name,
      'activityLevel': activityLevel.name,
      'dailyCalorieTarget': dailyCalorieTarget,
    };
  }

  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      sex: entity.sex,
      age: entity.age,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      goal: entity.goal,
      activityLevel: entity.activityLevel,
      dailyCalorieTarget: entity.dailyCalorieTarget,
    );
  }
}
