import 'dart:async';

import '../utils/utils.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // Set up dependencies
      await setupDeps();

      runApp(await builder());
    },
    (error, stackTrace) => kLog(
      '[Run Zoned Guarded] $error',
      stackTrace: stackTrace,
    ),
  );
}
