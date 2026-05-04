import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/metric_card.dart';
import '../../../tracking/presentation/controllers/meals_controller.dart';

import '../controllers/dashboard_controller.dart';
import '../widgets/navigation_shell.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(selectedDateProvider);
    final summary = ref.watch(dashboardControllerProvider(date));

    return NavigationShell(
      index: 0,
      child: AppScaffold(
        title: 'Dashboard',
        body: summary.when(
          data: (data) => ListView(
            children: [
              Text('Today overview', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MetricCard(label: 'Consumed', value: '${data.consumedCalories} kcal', icon: Icons.local_fire_department),
                  MetricCard(label: 'Remaining', value: '${data.remainingCalories} kcal', icon: Icons.flag),
                  MetricCard(label: 'Meals', value: data.mealCount.toString(), icon: Icons.restaurant),
                  MetricCard(label: 'Goal', value: '${data.goalCalories} kcal', icon: Icons.track_changes),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Macros', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      _macroRow('Protein', data.protein),
                      _macroRow('Carbs', data.carbs),
                      _macroRow('Fat', data.fat),
                    ],
                  ),
                ),
              ),
            ],
          ),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }

  Widget _macroRow(String label, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(label), Text('${value.toStringAsFixed(1)} g')],
      ),
    );
  }
}
