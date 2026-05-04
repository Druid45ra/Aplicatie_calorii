import '../../domain/entities/sync_payload.dart';
import 'remote_meal_entry_dto.dart';
import 'remote_user_profile_dto.dart';
import 'remote_weight_entry_dto.dart';

class SyncPayloadModel {
  const SyncPayloadModel({
    required this.profile,
    required this.meals,
    required this.weights,
    required this.generatedAt,
    required this.schemaVersion,
  });

  final RemoteUserProfileDto? profile;
  final List<RemoteMealEntryDto> meals;
  final List<RemoteWeightEntryDto> weights;
  final String generatedAt;
  final int schemaVersion;

  factory SyncPayloadModel.fromDomain(SyncPayload payload) {
    return SyncPayloadModel(
      profile: payload.profile == null ? null : RemoteUserProfileDto.fromEntity(payload.profile!),
      meals: payload.meals.map(RemoteMealEntryDto.fromEntity).toList(),
      weights: payload.weights.map(RemoteWeightEntryDto.fromEntity).toList(),

      generatedAt: payload.generatedAt.toIso8601String(),
      schemaVersion: payload.schemaVersion,
    );
  }

  SyncPayload toDomain() {
    return SyncPayload(
      profile: profile?.toEntity(),
      meals: meals.map((item) => item.toEntity()).toList(),
      weights: weights.map((item) => item.toEntity()).toList(),
      generatedAt: DateTime.tryParse(generatedAt) ?? DateTime.now(),
      schemaVersion: schemaVersion,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile': profile?.toMap(),
      'meals': meals.map((item) => item.toMap()).toList(),
      'weights': weights.map((item) => item.toMap()).toList(),
      'generatedAt': generatedAt,
      'schemaVersion': schemaVersion,
    };
  }

  factory SyncPayloadModel.fromMap(Map<String, dynamic> map) {
    return SyncPayloadModel(
      profile: map['profile'] == null
          ? null
          : RemoteUserProfileDto.fromMap(Map<String, dynamic>.from(map['profile'] as Map)),
      meals: ((map['meals'] as List?) ?? const [])
          .map((item) => RemoteMealEntryDto.fromMap(Map<String, dynamic>.from(item as Map)))
          .toList(),
      weights: ((map['weights'] as List?) ?? const [])
          .map((item) => RemoteWeightEntryDto.fromMap(Map<String, dynamic>.from(item as Map)))
          .toList(),
      generatedAt: map['generatedAt'] as String? ?? '',
      schemaVersion: (map['schemaVersion'] as num?)?.toInt() ?? 1,
    );
  }
}
