import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_utils.dart';
import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../controllers/weight_controller.dart';
import '../widgets/weight_line_chart.dart';

class WeightPage extends ConsumerWidget {
  const WeightPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entriesAsync = ref.watch(weightControllerProvider);

    return NavigationShell(
      index: 2,
      child: Scaffold(
        appBar: AppBar(title: const Text('Weight history')),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showAddDialog(context, ref),
          icon: const Icon(Icons.add),
          label: const Text('Entry'),
        ),
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
        ),
      ),
    );
  }

  Future<void> _showAddDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    DateTime selected = DateTime.now();

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add weight entry'),
          content: StatefulBuilder(
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
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    controller.dispose();
  }
}
