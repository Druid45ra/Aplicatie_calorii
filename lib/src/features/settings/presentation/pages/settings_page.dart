import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

<<<<<<< ours
<<<<<<< ours
=======
import '../../../../core/widgets/app_scaffold.dart';
import '../../../analytics/presentation/controllers/analytics_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
>>>>>>> theirs
=======
import '../../../../core/widgets/app_scaffold.dart';
import '../../../analytics/presentation/controllers/analytics_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
>>>>>>> theirs
import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../../../tracking/presentation/controllers/meals_controller.dart';
import '../../../weight/presentation/controllers/weight_controller.dart';
<<<<<<< ours
<<<<<<< ours
import '../controllers/settings_controller.dart';
import '../../../analytics/presentation/controllers/analytics_controller.dart';
import '../../../dashboard/presentation/controllers/dashboard_controller.dart';
import '../controllers/backup_controller.dart';
=======
=======
>>>>>>> theirs
import '../controllers/backup_controller.dart';
import '../controllers/remote_sync_controller.dart';
import '../controllers/settings_controller.dart';
import '../controllers/sync_controller.dart';
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileControllerProvider);
<<<<<<< ours
<<<<<<< ours

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
=======
=======
>>>>>>> theirs
    final syncStatus = ref.watch(syncStatusProvider);
    final remoteSyncState = ref.watch(remoteSyncControllerProvider);

    return NavigationShell(
      index: 4,
      child: AppScaffold(
        title: 'Settings',
        body: profile.when(
          data: (data) => ListView(
            children: [
              Card(
                child: ListTile(
                  title: const Text('Profile'),
                  subtitle: Text(data == null ? 'Not configured' : '${data.weightKg} kg • ${data.heightCm} cm • ${data.dailyCalorieTarget} kcal'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => context.go('/onboarding'),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Export local data'),
                  subtitle: const Text('Create a JSON backup of profile, meals and weights'),
                  trailing: const Icon(Icons.upload_file_outlined),
                  onTap: () async => ref.read(backupControllerProvider).exportData(),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Import local data'),
                  subtitle: const Text('Restore profile, meals and weights from JSON'),
                  trailing: const Icon(Icons.download_outlined),
                  onTap: () async {
                    await ref.read(backupControllerProvider).importData();
                    ref.invalidate(profileControllerProvider);
                    ref.invalidate(mealsControllerProvider);
                    ref.invalidate(weightControllerProvider);
                    ref.invalidate(analyticsControllerProvider);
                    ref.invalidate(dashboardControllerProvider(DateTime.now()));
                    if (context.mounted) {
                      context.go('/dashboard');
                    }
                  },
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Remote sync readiness'),
                  subtitle: syncStatus.when(
                    data: (status) => Text(status.message),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Text('Loading sync status...'),
                  ),
                  trailing: syncStatus.when(
                    data: (status) => Icon(
                      status.isRemoteReady ? Icons.cloud_done_outlined : Icons.cloud_off_outlined,
                    ),
                    error: (error, stackTrace) => const Icon(Icons.error_outline),
                    loading: () => const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('API endpoint'),
                  subtitle: syncStatus.when(
                    data: (status) => Text(status.endpoint),
                    error: (error, stackTrace) => const Text('Unavailable'),
                    loading: () => const Text('Loading endpoint...'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Pending sync operations'),
                  subtitle: syncStatus.when(
                    data: (status) => Text(status.pendingOperations.toString()),
                    error: (error, stackTrace) => const Text('Unavailable'),
                    loading: () => const Text('Loading queue...'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Push local data'),
                  subtitle: const Text('Upload local profile, meals, and weights to remote'),
                  trailing: const Icon(Icons.cloud_upload_outlined),
                  onTap: remoteSyncState.isLoading
                      ? null
                      : () async {
                          await ref.read(remoteSyncControllerProvider.notifier).push();
                          if (!context.mounted) {
                            return;
                          }
                          final result = ref.read(remoteSyncControllerProvider).valueOrNull;
                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.message)),
                            );
                          }
                        },
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Pull remote data'),
                  subtitle: const Text('Download remote profile, meals, and weights'),
                  trailing: const Icon(Icons.cloud_download_outlined),
                  onTap: remoteSyncState.isLoading
                      ? null
                      : () async {
                          await ref.read(remoteSyncControllerProvider.notifier).pull();
                          ref.invalidate(profileControllerProvider);
                          ref.invalidate(mealsControllerProvider);
                          ref.invalidate(weightControllerProvider);
                          ref.invalidate(analyticsControllerProvider);
                          ref.invalidate(dashboardControllerProvider(DateTime.now()));
                          if (!context.mounted) {
                            return;
                          }
                          final result = ref.read(remoteSyncControllerProvider).valueOrNull;
                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.message)),
                            );
                          }
                        },
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Sync now'),
                  subtitle: const Text('Run push + pull in one operation'),
                  trailing: remoteSyncState.isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.sync_outlined),
                  onTap: remoteSyncState.isLoading
                      ? null
                      : () async {
                          await ref.read(remoteSyncControllerProvider.notifier).syncNow();
                          ref.invalidate(profileControllerProvider);
                          ref.invalidate(mealsControllerProvider);
                          ref.invalidate(weightControllerProvider);
                          ref.invalidate(analyticsControllerProvider);
                          ref.invalidate(dashboardControllerProvider(DateTime.now()));
                          if (!context.mounted) {
                            return;
                          }
                          final result = ref.read(remoteSyncControllerProvider).valueOrNull;
                          if (result != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result.message)),
                            );
                          }
                        },
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Last sync result'),
                  subtitle: remoteSyncState.when(
                    data: (value) => Text(value?.message ?? 'No sync executed yet.'),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () => const Text('Sync in progress...'),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: ListTile(
                  title: const Text('Reset all local data'),
                  subtitle: const Text('Delete profile, meals and weight history'),
                  trailing: const Icon(Icons.delete_forever_outlined),
                  onTap: () => _confirmReset(context, ref),
                ),
              ),
              const SizedBox(height: 12),
              const Card(
                child: ListTile(
                  title: Text('Storage mode'),
                  subtitle: Text('Offline-first local persistence using Hive'),
                ),
              ),
              const SizedBox(height: 12),
              const Card(
                child: ListTile(
                  title: Text('Sync architecture'),
                  subtitle: Text('Remote sync client abstraction is wired and ready for a real API implementation.'),
                ),
              ),
            ],
          ),
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

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
<<<<<<< ours
<<<<<<< ours
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
=======
=======
>>>>>>> theirs
    final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Reset all data'),
            content: const Text('This will remove your profile, meals and weight history from local storage.'),
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
          ),
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
        ) ??
        false;

    if (!confirmed) {
      return;
    }

    await ref.read(settingsControllerProvider).resetAll();
<<<<<<< ours
<<<<<<< ours

    ref.invalidate(profileControllerProvider);
    ref.invalidate(mealsControllerProvider);
    ref.invalidate(weightControllerProvider);
=======
=======
>>>>>>> theirs
    ref.invalidate(profileControllerProvider);
    ref.invalidate(mealsControllerProvider);
    ref.invalidate(weightControllerProvider);
    ref.invalidate(analyticsControllerProvider);
    ref.invalidate(dashboardControllerProvider(DateTime.now()));
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs

    if (context.mounted) {
      context.go('/onboarding');
    }
  }
}
