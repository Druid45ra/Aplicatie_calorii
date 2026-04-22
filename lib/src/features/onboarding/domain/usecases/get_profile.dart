import '../entities/user_profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  const GetProfile(this.repository);

  final ProfileRepository repository;

<<<<<<< ours
  Future<UserProfile?> call() {
    return repository.getProfile();
  }
=======
  Future<UserProfile?> call() => repository.getProfile();
>>>>>>> theirs
}
