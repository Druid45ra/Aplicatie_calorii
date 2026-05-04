import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../../core/widgets/app_scaffold.dart';

import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../../domain/entities/meal_entry.dart';
import '../controllers/meals_controller.dart';
import '../widgets/meal_form_sheet.dart';

class TrackingPage extends ConsumerWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealsAsync = ref.watch(mealsControllerProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    return NavigationShell(
      index: 1,
      child: AppScaffold(
        title: 'Meals',

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showForm(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('Meal'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Selected date: ${AppDateUtils.formatDate(selectedDate)}'),
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
                      ref.read(selectedDateProvider.notifier).state = AppDateUtils.normalizeDate(picked);
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: mealsAsync.when(
                data: (meals) {
                  final filtered = meals.where((meal) => AppDateUtils.isSameDay(meal.date, selectedDate)).toList();
                  if (filtered.isEmpty) {
                    return const Center(child: Text('No meals for this day yet.'));
                  }
                  return ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final meal = filtered[index];
                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          title: Text(meal.name),
                          subtitle: Text('${meal.mealType} • ${meal.calories} kcal • P${meal.protein}/C${meal.carbs}/F${meal.fat}'),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _showForm(context, ref, initial: meal);
                              } else {
                                ref.read(mealsControllerProvider.notifier).remove(meal.id);
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(value: 'edit', child: Text('Edit')),
                              PopupMenuItem(value: 'delete', child: Text('Delete')),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (error, stackTrace) => Center(child: Text(error.toString())),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref, {MealEntry? initial}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => MealFormSheet(
        initial: initial,
        onSave: (entry) => ref.read(mealsControllerProvider.notifier).addOrUpdate(id: initial?.id, entry: entry),

      ),
    );
  }
}
