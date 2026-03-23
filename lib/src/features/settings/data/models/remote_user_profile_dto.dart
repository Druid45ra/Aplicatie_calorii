import '../../../onboarding/domain/entities/user_profile.dart';

class RemoteUserProfileDto {
  const RemoteUserProfileDto({
    required this.sex,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.goal,
    required this.activityLevel,
    required this.dailyCalorieTarget,
  });

  final String sex;
  final int age;
  final double heightCm;
  final double weightKg;
  final String goal;
  final String activityLevel;
  final int dailyCalorieTarget;

  factory RemoteUserProfileDto.fromEntity(UserProfile entity) {
    return RemoteUserProfileDto(
      sex: entity.sex.name,
      age: entity.age,
      heightCm: entity.heightCm,
      weightKg: entity.weightKg,
      goal: entity.goal.name,
      activityLevel: entity.activityLevel.name,
      dailyCalorieTarget: entity.dailyCalorieTarget,
    );
  }

  UserProfile toEntity() {
    return UserProfile(
      sex: BiologicalSex.values.byName(sex),
      age: age,
      heightCm: heightCm,
      weightKg: weightKg,
      goal: GoalType.values.byName(goal),
      activityLevel: ActivityLevel.values.byName(activityLevel),
      dailyCalorieTarget: dailyCalorieTarget,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'sex': sex,
      'age': age,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'goal': goal,
      'activityLevel': activityLevel,
      'dailyCalorieTarget': dailyCalorieTarget,
    };
  }

  factory RemoteUserProfileDto.fromMap(Map<String, dynamic> map) {
    return RemoteUserProfileDto(
      sex: map['sex'] as String? ?? 'other',
      age: (map['age'] as num?)?.toInt() ?? 0,
      heightCm: (map['heightCm'] as num?)?.toDouble() ?? 0,
      weightKg: (map['weightKg'] as num?)?.toDouble() ?? 0,
      goal: map['goal'] as String? ?? 'maintain',
      activityLevel: map['activityLevel'] as String? ?? 'moderate',
      dailyCalorieTarget: (map['dailyCalorieTarget'] as num?)?.toInt() ?? 2000,
    );
  }
}
