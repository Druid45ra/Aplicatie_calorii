import 'package:equatable/equatable.dart';

enum SyncMode { localOnly, remoteReady, live }

enum SyncState { idle, syncing, error }

class SyncStatus extends Equatable {
  const SyncStatus({
    required this.mode,
    required this.state,
    required this.lastSuccessfulSync,
    required this.pendingOperations,
    required this.endpoint,
    required this.message,
  });

  final SyncMode mode;
  final SyncState state;
  final DateTime? lastSuccessfulSync;
  final int pendingOperations;
  final String endpoint;
  final String message;

  bool get isRemoteReady => mode != SyncMode.localOnly;

  @override
  List<Object?> get props => [
        mode,
        state,
        lastSuccessfulSync,
        pendingOperations,
        endpoint,
        message,
      ];
}
