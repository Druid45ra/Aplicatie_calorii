import '../../../onboarding/domain/repositories/profile_repository.dart';
import '../../../tracking/domain/repositories/meal_repository.dart';
import '../../../weight/domain/repositories/weight_repository.dart';

class ResetLocalData {
  const ResetLocalData(
    this.profileRepository,
    this.mealRepository,
    this.weightRepository,
  );

  final ProfileRepository profileRepository;
  final MealRepository mealRepository;
  final WeightRepository weightRepository;

  Future<void> call() async {
    await profileRepository.clearProfile();
    await mealRepository.clearMeals();
    await weightRepository.clearEntries();
  }
}
