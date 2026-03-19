import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/onboarding/data/datasources/local_profile_datasource.dart';
import '../../features/onboarding/data/repositories/profile_repository_impl.dart';
import '../../features/onboarding/domain/repositories/profile_repository.dart';
import '../constants/app_boxes.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  await Hive.initFlutter();

  final settingsBox = await Hive.openBox<dynamic>(AppBoxes.settings);

  sl
    ..registerLazySingleton(() => LocalProfileDataSource(settingsBox))
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()),
    );
}
