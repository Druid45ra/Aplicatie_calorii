import '../entities/daily_summary.dart';
import '../repositories/dashboard_repository.dart';

class GetDailySummary {
  const GetDailySummary(this.repository);

  final DashboardRepository repository;

  Future<DailySummary> call(DateTime date) {
    return repository.getDailySummary(date);
  }
}
