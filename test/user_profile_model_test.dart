import 'package:flutter_test/flutter_test.dart';

import 'package:aplicatie_calorii/src/features/onboarding/data/models/user_profile_model.dart';
import 'package:aplicatie_calorii/src/features/onboarding/domain/entities/user_profile.dart';

void main() {
  test('falls back safely when stored enum values are unknown', () {
    final profile = UserProfileModel.fromMap(const {
      'sex': 'legacy',
      'age': 32,
      'heightCm': 180,
      'weightKg': 82,
      'goal': 'unsupported',
      'activityLevel': 'unknown',
      'dailyCalorieTarget': 2100,
    });

    expect(profile.sex, BiologicalSex.other);
    expect(profile.goal, GoalType.maintain);
    expect(profile.activityLevel, ActivityLevel.moderate);
    expect(profile.dailyCalorieTarget, 2100);
  });
}
