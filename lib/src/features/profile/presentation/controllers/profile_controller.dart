import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../../onboarding/domain/entities/user_profile.dart';
import '../../../onboarding/domain/usecases/get_profile.dart';
import '../../../onboarding/domain/usecases/save_profile.dart';

<<<<<<< ours
<<<<<<< ours
final profileControllerProvider =
    AsyncNotifierProvider<ProfileController, UserProfile?>(
      ProfileController.new,
    );
=======
final profileControllerProvider = AsyncNotifierProvider<ProfileController, UserProfile?>(ProfileController.new);
>>>>>>> theirs
=======
final profileControllerProvider = AsyncNotifierProvider<ProfileController, UserProfile?>(ProfileController.new);
>>>>>>> theirs

class ProfileController extends AsyncNotifier<UserProfile?> {
  late final GetProfile _getProfile = GetProfile(sl());
  late final SaveProfile _saveProfile = SaveProfile(sl());

  @override
<<<<<<< ours
<<<<<<< ours
  Future<UserProfile?> build() {
    return _getProfile();
  }

  Future<void> save(UserProfile profile) async {
    state = const AsyncLoading();

=======
=======
>>>>>>> theirs
  Future<UserProfile?> build() => _getProfile();

  Future<void> save(UserProfile profile) async {
    state = const AsyncLoading();
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
    state = await AsyncValue.guard(() async {
      await _saveProfile(profile);
      return _getProfile();
    });
  }
}
