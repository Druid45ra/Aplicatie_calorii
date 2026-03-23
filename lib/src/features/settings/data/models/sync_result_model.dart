import '../../domain/entities/sync_result.dart';

class SyncResultModel {
  const SyncResultModel({
    required this.success,
    required this.message,
    required this.receivedMeals,
    required this.receivedWeights,
    required this.syncedAt,
  });

  final bool success;
  final String message;
  final int receivedMeals;
  final int receivedWeights;
  final String? syncedAt;

  factory SyncResultModel.fromDomain(SyncResult result) {
    return SyncResultModel(
      success: result.success,
      message: result.message,
      receivedMeals: result.receivedMeals,
      receivedWeights: result.receivedWeights,
      syncedAt: result.syncedAt?.toIso8601String(),
    );
  }

  SyncResult toDomain() {
    return SyncResult(
      success: success,
      message: message,
      receivedMeals: receivedMeals,
      receivedWeights: receivedWeights,
      syncedAt: syncedAt == null ? null : DateTime.tryParse(syncedAt!),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'message': message,
      'receivedMeals': receivedMeals,
      'receivedWeights': receivedWeights,
      'syncedAt': syncedAt,
    };
  }

  factory SyncResultModel.fromMap(Map<String, dynamic> map) {
    return SyncResultModel(
      success: map['success'] as bool? ?? false,
      message: map['message'] as String? ?? '',
      receivedMeals: (map['receivedMeals'] as num?)?.toInt() ?? 0,
      receivedWeights: (map['receivedWeights'] as num?)?.toInt() ?? 0,
      syncedAt: map['syncedAt'] as String?,
    );
  }
}
