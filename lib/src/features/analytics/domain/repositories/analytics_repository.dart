import '../entities/analytics_snapshot.dart';

abstract class AnalyticsRepository {
  Future<AnalyticsSnapshot> getSnapshot();
}
