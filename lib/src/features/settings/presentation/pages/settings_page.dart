import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../dashboard/presentation/widgets/navigation_shell.dart';
import '../../../profile/presentation/controllers/profile_controller.dart';

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
                  const Card(
                    child: ListTile(
                      title: Text('Storage mode'),
                      subtitle: Text(
                        'Offline-first local persistence using Hive',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Card(
                    child: ListTile(
                      title: Text('Architecture'),
                      subtitle: Text(
                        'Clean Architecture + Riverpod + get_it + Hive',
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
}
