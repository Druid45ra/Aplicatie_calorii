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
      sex: _enumByName(
        BiologicalSex.values,
        map['sex'] as String?,
        BiologicalSex.other,
      ),
      age: (map['age'] as num?)?.toInt() ?? 0,
      heightCm: (map['heightCm'] as num?)?.toDouble() ?? 0,
      weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
      goal: _enumByName(
        GoalType.values,
        map['goal'] as String?,
        GoalType.maintain,
      ),
      activityLevel: _enumByName(
        ActivityLevel.values,
        map['activityLevel'] as String?,
        ActivityLevel.moderate,
      ),
      dailyCalorieTarget: (map['dailyCalorieTarget'] as num?)?.toInt() ?? 2000,
    );
  }

  Map<String, dynamic> toMap() => {
        'sex': sex.name,
        'age': age,
        'heightCm': heightCm,
        'weightKg': weightKg,
        'goal': goal.name,
        'activityLevel': activityLevel.name,
        'dailyCalorieTarget': dailyCalorieTarget,
      };

  factory UserProfileModel.fromEntity(UserProfile entity) => UserProfileModel(
        sex: entity.sex,
        age: entity.age,
        heightCm: entity.heightCm,
        weightKg: entity.weightKg,
        goal: entity.goal,
        activityLevel: entity.activityLevel,
        dailyCalorieTarget: entity.dailyCalorieTarget,
      );
}

T _enumByName<T extends Enum>(List<T> values, String? name, T fallback) {
  for (final value in values) {
    if (value.name == name) {
      return value;
    }
  }
  return fallback;
}
