import '../entities/analytics_snapshot.dart';
import '../repositories/analytics_repository.dart';

class GetAnalyticsSnapshot {
  const GetAnalyticsSnapshot(this.repository);

  final AnalyticsRepository repository;

<<<<<<< ours
  Future<AnalyticsSnapshot> call() {
    return repository.getSnapshot();
  }
=======
  Future<AnalyticsSnapshot> call() => repository.getSnapshot();
>>>>>>> theirs
}
