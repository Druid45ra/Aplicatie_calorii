import '../../../onboarding/domain/repositories/profile_repository.dart';
import '../../../tracking/domain/repositories/meal_repository.dart';
import '../../../weight/domain/repositories/weight_repository.dart';
import '../../domain/entities/sync_payload.dart';
import '../../domain/entities/sync_result.dart';
import '../../domain/repositories/remote_sync_repository.dart';
import '../datasources/remote_sync_datasource.dart';
import '../models/sync_payload_model.dart';

class RemoteSyncRepositoryImpl implements RemoteSyncRepository {
  const RemoteSyncRepositoryImpl(
    this.profileRepository,
    this.mealRepository,
    this.weightRepository,
    this.remoteDataSource,
  );

  final ProfileRepository profileRepository;
  final MealRepository mealRepository;
  final WeightRepository weightRepository;
  final RemoteSyncDataSource remoteDataSource;

  @override
  Future<SyncResult> pushLocalData() async {
    final payload = await _readLocalPayload();
    final result =
        await remoteDataSource.push(SyncPayloadModel.fromDomain(payload));
    return result.toDomain();
  }

  @override
  Future<SyncResult> pullRemoteData() async {
    final remotePayload = await remoteDataSource.pull();
    final domainPayload = remotePayload.toDomain();

    if (_isEmptyPayload(domainPayload)) {
      return SyncResult(
        success: false,
        message: 'No remote data available. Local data was left unchanged.',
        receivedMeals: 0,
        receivedWeights: 0,
        syncedAt: DateTime.now(),
      );
    }

    if (domainPayload.profile == null) {
      await profileRepository.clearProfile();
    } else {
      await profileRepository.saveProfile(domainPayload.profile!);
    }
    await mealRepository.saveMeals(domainPayload.meals);
    await weightRepository.saveEntries(domainPayload.weights);

    return SyncResult(
      success: true,
      message: 'Pull completed.',
      receivedMeals: domainPayload.meals.length,
      receivedWeights: domainPayload.weights.length,
      syncedAt: DateTime.now(),
    );
  }

  @override
  Future<SyncResult> syncNow() async {
    final payload = await _readLocalPayload();
    final result =
        await remoteDataSource.sync(SyncPayloadModel.fromDomain(payload));
    final pulled = await remoteDataSource.pull();
    final domainPayload = pulled.toDomain();

    if (!_isEmptyPayload(domainPayload)) {
      if (domainPayload.profile == null) {
        await profileRepository.clearProfile();
      } else {
        await profileRepository.saveProfile(domainPayload.profile!);
      }
      await mealRepository.saveMeals(domainPayload.meals);
      await weightRepository.saveEntries(domainPayload.weights);
    }

    return result.toDomain();
  }

  Future<SyncPayload> _readLocalPayload() async {
    final profile = await profileRepository.getProfile();
    final meals = await mealRepository.getMeals();
    final weights = await weightRepository.getEntries();

    return SyncPayload(
      profile: profile,
      meals: meals,
      weights: weights,
      generatedAt: DateTime.now(),
      schemaVersion: 1,
    );
  }

  bool _isEmptyPayload(SyncPayload payload) {
    return payload.profile == null &&
        payload.meals.isEmpty &&
        payload.weights.isEmpty;
  }
}
