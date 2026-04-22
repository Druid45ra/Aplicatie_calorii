<<<<<<< ours
<<<<<<< ours
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  runApp(const ProviderScope(child: CalorieTrackerApp()));
}
=======
=======
>>>>>>> theirs
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';
import 'src/core/services/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const ProviderScope(child: CalorieTrackerApp()));
}
<<<<<<< ours
>>>>>>> theirs
=======
>>>>>>> theirs
