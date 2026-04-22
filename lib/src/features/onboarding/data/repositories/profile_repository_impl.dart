import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local_profile_datasource.dart';
import '../models/user_profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this.localDataSource);

  final LocalProfileDataSource localDataSource;

  @override
<<<<<<< ours
  Future<UserProfile?> getProfile() {
    return localDataSource.getProfile();
  }
=======
  Future<UserProfile?> getProfile() => localDataSource.getProfile();
>>>>>>> theirs

  @override
  Future<void> saveProfile(UserProfile profile) {
    return localDataSource.saveProfile(UserProfileModel.fromEntity(profile));
  }

  @override
<<<<<<< ours
  Future<void> clearProfile() {
    return localDataSource.clearProfile();
  }
=======
  Future<void> clearProfile() => localDataSource.clearProfile();
>>>>>>> theirs
}
