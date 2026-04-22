import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class SaveProfile {
  const SaveProfile(this.repository);

  final ProfileRepository repository;

<<<<<<< ours
  Future<void> call(UserProfile profile) {
    return repository.saveProfile(profile);
  }
=======
  Future<void> call(UserProfile profile) => repository.saveProfile(profile);
>>>>>>> theirs
}
