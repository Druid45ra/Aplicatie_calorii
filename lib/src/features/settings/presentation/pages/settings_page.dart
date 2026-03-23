import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../../../tracking/presentation/controllers/meals_controller.dart';
import '../../../weight/presentation/controllers/weight_controller.dart';
import '../controllers/settings_controller.dart';
import '../../../analytics/presentation/controllers/analytics_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
import '../controllers/backup_controller.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);

    return NavigationShell(
      index: 4,
      child: Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: profile.when(
            data: (data) {
              return ListView(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Export local data'),
                      subtitle: const Text(
                        'Create a JSON backup of profile, meals and weights',
                      ),
                      trailing: const Icon(Icons.upload_file_outlined),
                      onTap: () async {
                        await ref.read(backupControllerProvider).exportData();
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: const Text('Import local data'),
                      subtitle: const Text(
                        'Restore profile, meals and weights from JSON',
                      ),
                      trailing: const Icon(Icons.download_outlined),
                      onTap: () async {
                        await ref.read(backupControllerProvider).importData();

                        ref.invalidate(profileControllerProvider);
                        ref.invalidate(mealsControllerProvider);
                        ref.invalidate(weightControllerProvider);
                        ref.invalidate(analyticsControllerProvider);
                        ref.invalidate(dashboardControllerProvider);

                        if (context.mounted) {
                          context.go('/dashboard');
                        }
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Profile'),
                      subtitle: Text(
                        data == null
                            ? 'Not configured'
                            : '${data.weightKg} kg • ${data.heightCm} cm • ${data.dailyCalorieTarget} kcal',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        context.go('/onboarding');
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: const Text('Edit profile'),
                      subtitle: const Text(
                        'Reopen onboarding with existing values',
                      ),
                      trailing: const Icon(Icons.edit_outlined),
                      onTap: () {
                        context.go('/onboarding');
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: ListTile(
                      title: const Text('Reset all local data'),
                      subtitle: const Text(
                        'Delete profile, meals and weight history',
                      ),
                      trailing: const Icon(Icons.delete_forever_outlined),
                      onTap: () => _confirmReset(context, ref),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Card(
                    child: ListTile(
                      title: Text('Storage mode'),
                      subtitle: Text(
                        'Offline-first local persistence using Hive',
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

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Reset all data'),
              content: const Text(
                'This will remove your profile, meals and weight history from local storage.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Reset'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await ref.read(settingsControllerProvider).resetAll();

    ref.invalidate(profileControllerProvider);
    ref.invalidate(mealsControllerProvider);
    ref.invalidate(weightControllerProvider);

    if (context.mounted) {
      context.go('/onboarding');
    }
  }
}
