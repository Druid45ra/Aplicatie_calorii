import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

<<<<<<< ours
import '../../../../core/widgets/metric_card.dart';
import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../../../tracking/presentation/controllers/meals_controller.dart';
import '../controllers/analytics_controller.dart';
import '../widgets/calorie_bar_chart.dart';
=======
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/metric_card.dart';
import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../controllers/analytics_controller.dart';
>>>>>>> theirs

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(analyticsControllerProvider);
<<<<<<< ours
    final mealsAsync = ref.watch(mealsControllerProvider);

    return NavigationShell(
      index: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Analytics')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: snapshot.when(
            data: (data) {
              return mealsAsync.when(
                data: (meals) {
                  return ListView(
                    children: [
                      GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          MetricCard(
                            label: 'Avg calories',
                            value: data.averageCalories.toStringAsFixed(0),
                            icon: Icons.local_fire_department,
                          ),
                          MetricCard(
                            label: 'Avg weight',
                            value:
                                '${data.averageWeight.toStringAsFixed(1)} kg',
                            icon: Icons.monitor_weight,
                          ),
                          MetricCard(
                            label: 'Weight change',
                            value: '${data.weightChange.toStringAsFixed(1)} kg',
                            icon: Icons.show_chart,
                          ),
                          MetricCard(
                            label: 'Adherence',
                            value:
                                '${(data.adherenceRate * 100).toStringAsFixed(0)}%',
                            icon: Icons.verified,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (meals.isNotEmpty) ...[
                        Text(
                          'Calorie trend',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        CalorieBarChart(meals: meals),
                      ],
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return Center(child: Text(error.toString()));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
=======
    return NavigationShell(
      index: 3,
      child: AppScaffold(
        title: 'Analytics',
        body: snapshot.when(
          data: (data) => GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            children: [
              MetricCard(label: 'Avg calories', value: data.averageCalories.toStringAsFixed(0), icon: Icons.local_fire_department),
              MetricCard(label: 'Avg weight', value: '${data.averageWeight.toStringAsFixed(1)} kg', icon: Icons.monitor_weight),
              MetricCard(label: 'Weight change', value: '${data.weightChange.toStringAsFixed(1)} kg', icon: Icons.show_chart),
              MetricCard(label: 'Adherence', value: '${(data.adherenceRate * 100).toStringAsFixed(0)}%', icon: Icons.verified),
            ],
          ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
>>>>>>> theirs
        ),
      ),
    );
  }
}
