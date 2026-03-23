import 'package:equatable/equatable.dart';

import '../../../onboarding/domain/entities/user_profile.dart';
import '../../../tracking/domain/entities/meal_entry.dart';
import '../../../weight/domain/entities/weight_entry.dart';

class SyncPayload extends Equatable {
  const SyncPayload({
    required this.profile,
    required this.meals,
    required this.weights,
    required this.generatedAt,
    required this.schemaVersion,
  });

  final UserProfile? profile;
  final List<MealEntry> meals;
  final List<WeightEntry> weights;
  final DateTime generatedAt;
  final int schemaVersion;

  @override
  List<Object?> get props => [
        profile,
        meals,
        weights,
        generatedAt,
        schemaVersion,
      ];
}
