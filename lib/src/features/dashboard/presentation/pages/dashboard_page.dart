import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

<<<<<<< ours
import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/metric_card.dart';
=======
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/metric_card.dart';
import '../../../tracking/presentation/controllers/meals_controller.dart';
>>>>>>> theirs
import '../controllers/dashboard_controller.dart';
import '../widgets/navigation_shell.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
<<<<<<< ours
    final selectedDate = ref.watch(dashboardSelectedDateProvider);
    final summary = ref.watch(dashboardControllerProvider(selectedDate));

    return NavigationShell(
      index: 0,
      child: Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: summary.when(
            data: (data) {
              return ListView(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Selected date: ${AppDateUtils.formatDate(selectedDate)}',
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            ref
                                .read(dashboardSelectedDateProvider.notifier)
                                .state = AppDateUtils.normalizeDate(
                              picked,
                            );
                          }
                        },
                        icon: const Icon(Icons.calendar_today),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Daily overview',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      MetricCard(
                        label: 'Consumed',
                        value: '${data.consumedCalories} kcal',
                        icon: Icons.local_fire_department,
                      ),
                      MetricCard(
                        label: 'Remaining',
                        value: '${data.remainingCalories} kcal',
                        icon: Icons.flag,
                      ),
                      MetricCard(
                        label: 'Meals',
                        value: data.mealCount.toString(),
                        icon: Icons.restaurant,
                      ),
                      MetricCard(
                        label: 'Goal',
                        value: '${data.goalCalories} kcal',
                        icon: Icons.track_changes,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Macros',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          _macroRow('Protein', data.protein),
                          _macroRow('Carbs', data.carbs),
                          _macroRow('Fat', data.fat),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text(error.toString()));
            },
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
=======
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
>>>>>>> theirs
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
