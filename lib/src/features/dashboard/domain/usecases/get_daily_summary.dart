import '../entities/daily_summary.dart';
import '../repositories/dashboard_repository.dart';

class GetDailySummary {
  const GetDailySummary(this.repository);

  final DashboardRepository repository;

<<<<<<< ours
<<<<<<< ours
  Future<DailySummary> call(DateTime date) {
    return repository.getDailySummary(date);
  }
=======
  Future<DailySummary> call(DateTime date) => repository.getDailySummary(date);
>>>>>>> theirs
=======
  Future<DailySummary> call(DateTime date) => repository.getDailySummary(date);
>>>>>>> theirs
}
