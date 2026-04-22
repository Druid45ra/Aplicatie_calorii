import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationShell extends StatelessWidget {
<<<<<<< ours
<<<<<<< ours
  const NavigationShell({
    required this.child,
    required this.index,
    super.key,
  });
=======
  const NavigationShell({required this.child, required this.index, super.key});
>>>>>>> theirs
=======
  const NavigationShell({required this.child, required this.index, super.key});
>>>>>>> theirs

  final Widget child;
  final int index;

<<<<<<< ours
<<<<<<< ours
  static const _tabs = [
    '/dashboard',
    '/tracking',
    '/weight',
    '/analytics',
    '/settings',
  ];
=======
  static const _tabs = ['/dashboard', '/tracking', '/weight', '/analytics', '/settings'];
>>>>>>> theirs
=======
  static const _tabs = ['/dashboard', '/tracking', '/weight', '/analytics', '/settings'];
>>>>>>> theirs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
<<<<<<< ours
<<<<<<< ours
        onDestinationSelected: (value) {
          context.go(_tabs[value]);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Meals',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_weight_outlined),
            selectedIcon: Icon(Icons.monitor_weight),
            label: 'Weight',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Analytics',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
=======
=======
>>>>>>> theirs
        onDestinationSelected: (value) => context.go(_tabs[value]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu_outlined), selectedIcon: Icon(Icons.restaurant_menu), label: 'Meals'),
          NavigationDestination(icon: Icon(Icons.monitor_weight_outlined), selectedIcon: Icon(Icons.monitor_weight), label: 'Weight'),
          NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: 'Analytics'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), selectedIcon: Icon(Icons.settings), label: 'Settings'),
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
        ],
      ),
    );
  }
}
