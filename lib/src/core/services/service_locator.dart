import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/analytics/data/repositories/analytics_repository_impl.dart';
import '../../features/analytics/domain/repositories/analytics_repository.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/onboarding/data/datasources/local_profile_datasource.dart';
import '../../features/onboarding/data/repositories/profile_repository_impl.dart';
import '../../features/onboarding/domain/repositories/profile_repository.dart';
import '../../features/tracking/data/datasources/local_meal_datasource.dart';
import '../../features/tracking/data/repositories/meal_repository_impl.dart';
import '../../features/tracking/domain/repositories/meal_repository.dart';
import '../../features/weight/data/datasources/local_weight_datasource.dart';
import '../../features/weight/data/repositories/weight_repository_impl.dart';
import '../../features/weight/domain/repositories/weight_repository.dart';
import '../constants/app_boxes.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  await Hive.initFlutter();

  final settingsBox = await Hive.openBox<dynamic>(AppBoxes.settings);
  final mealsBox = await Hive.openBox<dynamic>(AppBoxes.meals);
  final weightsBox = await Hive.openBox<dynamic>(AppBoxes.weights);

  sl
    ..registerLazySingleton(() => LocalProfileDataSource(settingsBox))
    ..registerLazySingleton(() => LocalMealDataSource(mealsBox))
    ..registerLazySingleton(() => LocalWeightDataSource(weightsBox))
    ..registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()),
    )
    ..registerLazySingleton<MealRepository>(() => MealRepositoryImpl(sl()))
    ..registerLazySingleton<WeightRepository>(() => WeightRepositoryImpl(sl()))
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(sl(), sl()),
    )
    ..registerLazySingleton<AnalyticsRepository>(
      () => AnalyticsRepositoryImpl(sl(), sl()),
    );
}
