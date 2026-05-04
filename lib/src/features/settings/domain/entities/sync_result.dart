import 'package:equatable/equatable.dart';

class SyncResult extends Equatable {
  const SyncResult({
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
  final DateTime? syncedAt;

  @override
  List<Object?> get props => [
        success,
        message,
        receivedMeals,
        receivedWeights,
        syncedAt,
      ];
}
