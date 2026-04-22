import 'package:flutter_riverpod/flutter_riverpod.dart';

<<<<<<< ours
import '../../../../core/utils/date_utils.dart';
=======
>>>>>>> theirs
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/daily_summary.dart';
import '../../domain/usecases/get_daily_summary.dart';

<<<<<<< ours
final dashboardSelectedDateProvider = StateProvider<DateTime>(
  (ref) => AppDateUtils.normalizeDate(DateTime.now()),
);

final dashboardControllerProvider =
    FutureProvider.family<DailySummary, DateTime>((ref, date) {
      return GetDailySummary(sl())(date);
    });
=======
final dashboardControllerProvider = FutureProvider.family<DailySummary, DateTime>((ref, date) {
  return GetDailySummary(sl())(date);
});
>>>>>>> theirs
