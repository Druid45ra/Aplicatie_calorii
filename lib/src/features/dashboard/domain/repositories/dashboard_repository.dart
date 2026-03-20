import '../entities/daily_summary.dart';

abstract class DashboardRepository {
  Future<DailySummary> getDailySummary(DateTime date);
}
