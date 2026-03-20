import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../../core/services/service_locator.dart';
import '../../domain/entities/daily_summary.dart';
import '../../domain/usecases/get_daily_summary.dart';

final dashboardSelectedDateProvider = StateProvider<DateTime>(
  (ref) => AppDateUtils.normalizeDate(DateTime.now()),
);

final dashboardControllerProvider =
    FutureProvider.family<DailySummary, DateTime>((ref, date) {
      return GetDailySummary(sl())(date);
    });
