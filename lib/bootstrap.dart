import 'dart:async';

import 'package:error_logging_core/error_logging_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/app.dart';
import 'package:men_you/app_dependencies.dart';
import 'package:men_you/flavors.dart';
import 'package:men_you/logging/app_logging/logger_config.dart';
import 'package:men_you/logging/app_logging/provider_logger.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Runs any necessary Flutter or Platform specific initialization code before calling `runApp`.
/// Think: any code that I don't expect to change between apps.
Future<void> bootstrap(Flavor flavor, WidgetsBinding widgetsBinding) async {
  //* Keep the splash screen until told to remove
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //* Turn off the # in the URLs on the web
  usePathUrlStrategy();

  //* Configure logging and error handling
  final loggingRepository = FakeErrorLoggingRepository();
  await loggingRepository.init();

  final logger = Logger(
    filter: AppLogFilter(flavor),
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 12,
    ),
    output: AppLogOutput(loggingRepository),
  );

  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers(logger);

  //* Set all the shared preferences to be prefixed with app name
  // TODO: Change this to your app's name
  SharedPreferences.setPrefix('templateApp.');

  //* Android specific settings
  if (defaultTargetPlatform == TargetPlatform.android) {
    //* Sets edge-to-edge system UI mode on Android 12+
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarContrastEnforced: true,
      ),
    );
    await setOptimalDisplayMode();
  }

  runApp(
    ProviderScope(
      observers: [
        ProviderLogger(logger),
      ],
      overrides: [
        loggerProvider.overrideWithValue(logger),
        errorLoggingRepositoryProvider.overrideWithValue(loggingRepository),
        flavorProvider.overrideWithValue(flavor),
      ],
      child: const App(),
    ),
  );
}

void registerErrorHandlers(Logger logger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    logger.f(
      'Uncaught flutter error: ${details.exception}',
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    logger.e('Platform error: $error', error: error, stackTrace: stack);
    return true;
  };

  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    logger.w(
      'Error building widget: ${details.exception}',
      error: details.exception,
      stackTrace: details.stack,
    );
    //? I think this should just be a widget, not a whole page
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('An error occurred'),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

// Code taken from https://stackoverflow.com/questions/63631522/flutter-120fps-issue
/// Enables high refresh rate for devices where it was previously disabled
Future<void> setOptimalDisplayMode() async {
  final supported = await FlutterDisplayMode.supported;
  final active = await FlutterDisplayMode.active;

  final sameResolution = supported
      .where(
        (DisplayMode m) => m.width == active.width && m.height == active.height,
      )
      .toList()
    ..sort(
      (DisplayMode a, DisplayMode b) => b.refreshRate.compareTo(a.refreshRate),
    );

  final mostOptimalMode = sameResolution.isNotEmpty ? sameResolution.first : active;

  // This setting is per session.
  await FlutterDisplayMode.setPreferredMode(mostOptimalMode);
}
