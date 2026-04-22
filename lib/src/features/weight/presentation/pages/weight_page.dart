import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
<<<<<<< ours
<<<<<<< ours
import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../controllers/weight_controller.dart';
import '../widgets/weight_line_chart.dart';
=======
import '../../../../core/widgets/app_scaffold.dart';
import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../controllers/weight_controller.dart';
>>>>>>> theirs
=======
import '../../../../core/widgets/app_scaffold.dart';
import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../controllers/weight_controller.dart';
>>>>>>> theirs

class WeightPage extends ConsumerWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(weightControllerProvider);

    return NavigationShell(
      index: 2,
<<<<<<< ours
<<<<<<< ours
      child: Scaffold(
        appBar: AppBar(title: const Text('Weight history')),
=======
      child: AppScaffold(
        title: 'Weight evolution',
>>>>>>> theirs
=======
      child: AppScaffold(
        title: 'Weight evolution',
>>>>>>> theirs
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddDialog(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('Entry'),
        ),
<<<<<<< ours
<<<<<<< ours
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: entriesAsync.when(
            data: (entries) {
              if (entries.isEmpty) {
                return const Center(child: Text('No weight entries yet.'));
              }

              return ListView(
                children: [
                  WeightLineChart(entries: entries),
                  const SizedBox(height: 16),
                  ...entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: const CircleAvatar(
                            child: Icon(Icons.monitor_weight),
                          ),
                          title: Text(
                            '${entry.weightKg.toStringAsFixed(1)} kg',
                          ),
                          subtitle: Text(AppDateUtils.formatDate(entry.date)),
                          trailing: IconButton(
                            onPressed: () {
                              ref
                                  .read(weightControllerProvider.notifier)
                                  .removeEntry(entry.id);
                            },
                            icon: const Icon(Icons.delete_outline),
                          ),
                        ),
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
=======
>>>>>>> theirs
        body: entriesAsync.when(
          data: (entries) {
            if (entries.isEmpty) {
              return const Center(child: Text('No weight entries yet.'));
            }
            return ListView.separated(
              itemCount: entries.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final entry = entries[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: const CircleAvatar(child: Icon(Icons.monitor_weight)),
                    title: Text('${entry.weightKg.toStringAsFixed(1)} kg'),
                    subtitle: Text(AppDateUtils.formatDate(entry.date)),
                    trailing: IconButton(
                      onPressed: () => ref.read(weightControllerProvider.notifier).removeEntry(entry.id),
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          loading: () => const Center(child: CircularProgressIndicator()),
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
        ),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    DateTime selected = DateTime.now();
<<<<<<< ours
<<<<<<< ours

=======
>>>>>>> theirs
=======
>>>>>>> theirs
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add weight entry'),
          content: StatefulBuilder(
<<<<<<< ours
<<<<<<< ours
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(AppDateUtils.formatDate(selected)),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selected,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        setState(() {
                          selected = picked;
                        });
                      }
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final parsed = double.tryParse(controller.text.trim());

                if (parsed != null && parsed > 0) {
                  ref
                      .read(weightControllerProvider.notifier)
                      .addEntry(parsed, selected);
                  Navigator.of(context).pop();
                }
=======
=======
>>>>>>> theirs
            builder: (context, setState) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(labelText: 'Weight (kg)'),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(AppDateUtils.formatDate(selected)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selected,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => selected = picked);
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
            FilledButton(
              onPressed: () {
                ref.read(weightControllerProvider.notifier).addEntry(double.parse(controller.text), selected);
                Navigator.of(context).pop();
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
<<<<<<< ours
<<<<<<< ours

=======
>>>>>>> theirs
=======
>>>>>>> theirs
    controller.dispose();
  }
}
