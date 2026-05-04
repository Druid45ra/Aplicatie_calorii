import 'package:go_router/go_router.dart';

import '../../core/services/service_locator.dart';
import '../../features/analytics/presentation/pages/analytics_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/domain/repositories/profile_repository.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/tracking/presentation/pages/tracking_page.dart';
import '../../features/weight/presentation/pages/weight_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/dashboard',
    redirect: (context, state) async {
      final profile = await sl<ProfileRepository>().getProfile();
      final isOnboarding = state.matchedLocation == '/onboarding';

      if (profile == null && !isOnboarding) {
        return '/onboarding';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardPage(),
      ),
      GoRoute(
        path: '/tracking',
        builder: (context, state) => const TrackingPage(),
      ),
      GoRoute(path: '/weight', builder: (context, state) => const WeightPage()),
      GoRoute(
        path: '/analytics',
        builder: (context, state) => const AnalyticsPage(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
}
