import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/onboarding/data/datasources/local_profile_datasource.dart';
import '../../features/onboarding/data/repositories/profile_repository_impl.dart';
import '../../features/onboarding/domain/repositories/profile_repository.dart';
import '../../features/tracking/data/datasources/local_meal_datasource.dart';
import '../../features/tracking/data/repositories/meal_repository_impl.dart';
import '../../features/tracking/domain/repositories/meal_repository.dart';
import '../constants/app_boxes.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  await Hive.initFlutter();

  final settingsBox = await Hive.openBox<dynamic>(AppBoxes.settings);
  final mealsBox = await Hive.openBox<dynamic>(AppBoxes.meals);

  sl
    ..registerLazySingleton(() => LocalProfileDataSource(settingsBox))
    ..registerLazySingleton(() => LocalMealDataSource(mealsBox))
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()),
    )
    ..registerLazySingleton<MealRepository>(() => MealRepositoryImpl(sl()));
}
