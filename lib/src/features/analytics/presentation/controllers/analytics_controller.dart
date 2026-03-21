import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/service_locator.dart';
import '../../domain/entities/analytics_snapshot.dart';
import '../../domain/usecases/get_analytics_snapshot.dart';

final analyticsControllerProvider = FutureProvider<AnalyticsSnapshot>((ref) {
  return GetAnalyticsSnapshot(sl())();
});
