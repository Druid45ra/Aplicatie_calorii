import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../../onboarding/data/models/user_profile_model.dart';
import '../../../onboarding/domain/repositories/profile_repository.dart';
import '../../../tracking/data/models/meal_entry_model.dart';
import '../../../tracking/domain/repositories/meal_repository.dart';
import '../../../weight/data/models/weight_entry_model.dart';
import '../../../weight/domain/repositories/weight_repository.dart';
import '../../domain/entities/app_backup.dart';
import '../../domain/repositories/backup_repository.dart';

class BackupRepositoryImpl implements BackupRepository {
  BackupRepositoryImpl(
    this.profileRepository,
    this.mealRepository,
    this.weightRepository,
  );

  final ProfileRepository profileRepository;
  final MealRepository mealRepository;
  final WeightRepository weightRepository;

  @override
  Future<void> exportBackup() async {
    final profile = await profileRepository.getProfile();
    final meals = await mealRepository.getMeals();
    final weights = await weightRepository.getEntries();

    final backup = AppBackup(
      profile: profile == null
          ? null
          : UserProfileModel.fromEntity(profile).toMap(),
      meals: meals
          .map((item) => MealEntryModel.fromEntity(item).toMap())
          .toList(),
      weights: weights
          .map((item) => WeightEntryModel.fromEntity(item).toMap())
          .toList(),
    );

    final jsonString = const JsonEncoder.withIndent(
      '  ',
    ).convert(backup.toMap());

    await SharePlus.instance.share(
      ShareParams(
        text: 'Calorie Compass backup export',
        files: [
          XFile.fromData(utf8.encode(jsonString), mimeType: 'application/json'),
        ],
        fileNameOverrides: const ['calorie_compass_backup.json'],
      ),
    );
  }

  @override
  Future<void> importBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true,
    );

    if (result == null || result.files.isEmpty) {
      return;
    }

    final bytes = result.files.single.bytes;
    if (bytes == null) {
      return;
    }

    final jsonString = utf8.decode(bytes);
    final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    final backup = AppBackup.fromMap(decoded);

    if (backup.profile != null) {
      final profile = UserProfileModel.fromMap(backup.profile!);
      await profileRepository.saveProfile(profile);
    } else {
      await profileRepository.clearProfile();
    }

    final meals = backup.meals.map(MealEntryModel.fromMap).toList();
    await mealRepository.saveMeals(meals);

    final weights = backup.weights.map(WeightEntryModel.fromMap).toList();
    await weightRepository.saveEntries(weights);
  }
}
