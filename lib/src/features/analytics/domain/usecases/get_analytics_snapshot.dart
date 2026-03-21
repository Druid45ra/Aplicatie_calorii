import '../entities/analytics_snapshot.dart';
import '../repositories/analytics_repository.dart';

class GetAnalyticsSnapshot {
  const GetAnalyticsSnapshot(this.repository);

  final AnalyticsRepository repository;

  Future<AnalyticsSnapshot> call() {
    return repository.getSnapshot();
  }
}
