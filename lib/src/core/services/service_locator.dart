import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

<<<<<<< ours
=======
import '../network/api_config.dart';
import '../network/noop_remote_sync_client.dart';
import '../network/remote_sync_client.dart';
>>>>>>> theirs
import '../../features/analytics/data/repositories/analytics_repository_impl.dart';
import '../../features/analytics/domain/repositories/analytics_repository.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/repositories/dashboard_repository.dart';
import '../../features/onboarding/data/datasources/local_profile_datasource.dart';
import '../../features/onboarding/data/repositories/profile_repository_impl.dart';
import '../../features/onboarding/domain/repositories/profile_repository.dart';
<<<<<<< ours
=======
import '../../features/settings/data/repositories/backup_repository_impl.dart';
import '../../features/settings/data/repositories/remote_sync_repository_impl.dart';
import '../../features/settings/data/repositories/sync_repository_impl.dart';
import '../../features/settings/domain/repositories/backup_repository.dart';
import '../../features/settings/domain/repositories/remote_sync_repository.dart';
import '../../features/settings/domain/repositories/sync_repository.dart';
import '../../features/settings/data/datasources/mock_remote_sync_datasource.dart';
import '../../features/settings/data/datasources/remote_sync_datasource.dart';
>>>>>>> theirs
import '../../features/tracking/data/datasources/local_meal_datasource.dart';
import '../../features/tracking/data/repositories/meal_repository_impl.dart';
import '../../features/tracking/domain/repositories/meal_repository.dart';
import '../../features/weight/data/datasources/local_weight_datasource.dart';
import '../../features/weight/data/repositories/weight_repository_impl.dart';
import '../../features/weight/domain/repositories/weight_repository.dart';
<<<<<<< ours
import '../../features/settings/data/repositories/backup_repository_impl.dart';
import '../../features/settings/domain/repositories/backup_repository.dart';
=======
>>>>>>> theirs
import '../constants/app_boxes.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  await Hive.initFlutter();
<<<<<<< ours

=======
>>>>>>> theirs
  final settingsBox = await Hive.openBox<dynamic>(AppBoxes.settings);
  final mealsBox = await Hive.openBox<dynamic>(AppBoxes.meals);
  final weightsBox = await Hive.openBox<dynamic>(AppBoxes.weights);

  sl
<<<<<<< ours
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
    )
    ..registerLazySingleton<BackupRepository>(
  () => BackupRepositoryImpl(sl(), sl(), sl()),
);
=======
    ..registerLazySingleton(
      () => const ApiConfig(
        baseUrl: 'https://api.example.com',
        connectTimeout: Duration(seconds: 15),
        receiveTimeout: Duration(seconds: 15),
      ),
    )
    ..registerLazySingleton<RemoteSyncClient>(() => NoopRemoteSyncClient(sl()))
    ..registerLazySingleton(() => LocalProfileDataSource(settingsBox))
    ..registerLazySingleton(() => LocalMealDataSource(mealsBox))
    ..registerLazySingleton(() => LocalWeightDataSource(weightsBox))
    ..registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(sl()))
    ..registerLazySingleton<MealRepository>(() => MealRepositoryImpl(sl()))
    ..registerLazySingleton<WeightRepository>(() => WeightRepositoryImpl(sl()))
    ..registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(sl(), sl()))
    ..registerLazySingleton<AnalyticsRepository>(() => AnalyticsRepositoryImpl(sl(), sl()))
    ..registerLazySingleton<BackupRepository>(() => BackupRepositoryImpl(sl(), sl(), sl()))
    ..registerLazySingleton<RemoteSyncDataSource>(() => MockRemoteSyncDataSource())
    ..registerLazySingleton<RemoteSyncRepository>(() => RemoteSyncRepositoryImpl(sl(), sl(), sl(), sl()))
    ..registerLazySingleton<SyncRepository>(() => SyncRepositoryImpl(sl()));
>>>>>>> theirs
}
