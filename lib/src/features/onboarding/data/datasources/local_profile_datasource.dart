import 'package:hive/hive.dart';

import '../models/user_profile_model.dart';

class LocalProfileDataSource {
  LocalProfileDataSource(this.box);

  final Box<dynamic> box;
  static const _profileKey = 'user_profile';

  Future<UserProfileModel?> getProfile() async {
    final raw = box.get(_profileKey);
<<<<<<< ours

    if (raw is Map) {
      return UserProfileModel.fromMap(raw);
    }

    return null;
  }

  Future<void> saveProfile(UserProfileModel profile) async {
    await box.put(_profileKey, profile.toMap());
  }

  Future<void> clearProfile() async {
    await box.delete(_profileKey);
  }
=======
    if (raw is Map) {
      return UserProfileModel.fromMap(raw);
    }
    return null;
  }

  Future<void> saveProfile(UserProfileModel profile) => box.put(_profileKey, profile.toMap());

  Future<void> clearProfile() => box.delete(_profileKey);
>>>>>>> theirs
}
