import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:men_you/bootstrap.dart';
import 'package:men_you/firebase_options.dart';
import 'package:men_you/flavors.dart';

Future<void> main() async {
  await runZonedGuarded(
    () async {
      final binding = WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await bootstrap(Flavor.staging, binding);
    },
    (Object error, StackTrace? stack) {
      //* Add any additional error handling logic here. E.g. Log to Crashlytics
      log(
        'runZonedGuarded: Caught error: $error',
        time: DateTime.now(),
        name: 'main',
        error: error,
        stackTrace: stack,
      );
    },
  );
}
