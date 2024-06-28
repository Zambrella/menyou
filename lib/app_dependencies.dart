// Mostly copied from https://github.com/lichess-org/mobile/blob/main/lib/src/app_dependencies.dart
// Sets up the app specific dependencies.
// Any Flutter or Platform specific initialization shoudld be done in the bootstrap function.

import 'dart:async';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:error_logging_core/error_logging_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:logger/logger.dart';
import 'package:men_you/authentication/providers/authentication_providers.dart';
import 'package:men_you/flavors.dart';
import 'package:men_you/repository_providers.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_dependencies.freezed.dart';
part 'app_dependencies.g.dart';

@freezed
class AppDependencies with _$AppDependencies {
  const factory AppDependencies({
    required PackageInfo packageInfo,
    required BaseDeviceInfo deviceInfo,
    required SharedPreferences sharedPreferences,
    required Version appVersion,
  }) = _AppDependencies;
}

// Created two separate providers because some of the dependencies inside the appDependenciesProvider
// are needed by some of the providers in the serviceInitialisationProvider.

@Riverpod(keepAlive: true)
Future<AppDependencies> appDependencies(
  AppDependenciesRef ref,
) async {
  final flavor = ref.read(flavorProvider);
  final logger = ref.read(loggerProvider);
  // ignore: cascade_invocations
  logger.i('App dependency initialization starting.');
  //* These dependencies can be made available synchronously throughout the app now.
  //* See sharedPrefs provider as an example.
  final pInfo = await PackageInfo.fromPlatform();
  final deviceInfo = await DeviceInfoPlugin().deviceInfo;
  final prefs = await SharedPreferences.getInstance();
  final appVersion = Version.parse(pInfo.version);
  await dotenv.load(
    fileName: switch (flavor) {
      Flavor.dev => 'env/.development.env',
      Flavor.staging => 'env/.staging.env',
      Flavor.prod => 'env/.production.env',
    },
  );
  // Other examples: database connection, sound pool, vibration service, session storage.

  logger.i('Dependency initialization successful.');

  return AppDependencies(
    packageInfo: pInfo,
    deviceInfo: deviceInfo,
    sharedPreferences: prefs,
    appVersion: appVersion,
  );
}

@riverpod
FutureOr<void> serviceInitialisation(ServiceInitialisationRef ref) async {
  await ref.watch(appDependenciesProvider.future);
  final logger = ref.read(loggerProvider);
  // ignore: cascade_invocations
  logger.i('Service initialization starting.');

  // Waiting for the intial auth event to complete to prevent potential of going from loading -> unauthenticated -> authenticated
  // when the user is already authenticated, it's just that the auth state hasn't been emitted yet.
  final _ = await ref.read(authStateChangesProvider.future);

  // Initialize services
  await ref.read(errorLoggingRepositoryProvider).init();
  await ref.read(analyticsRepositoryProvider).init();
  await ref.read(purchasesRepositoryProvider).init(isDebugMode: kDebugMode);

  // Fetch the opt-in settings and enable/disable services accordingly
  final optInSettings = await ref.read(dataPrivacyRepositoryProvider).fetchPrivacySettings();
  if (optInSettings != null) {
    if (optInSettings.basic) {
      await ref.read(analyticsRepositoryProvider).enableAnalytics(enable: true);
      await ref.read(errorLoggingRepositoryProvider).enableLogging(enable: true);
    } else {
      await ref.read(analyticsRepositoryProvider).enableAnalytics(enable: false);
      await ref.read(errorLoggingRepositoryProvider).enableLogging(enable: false);
    }
  }

  logger.i('Service initialization successful.');
}

@Riverpod(keepAlive: true)
ErrorLoggingRepository errorLoggingRepository(ErrorLoggingRepositoryRef ref) {
  // Overriden in lib/bootstrap.dart
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
Logger logger(LoggerRef ref) {
  // Overriden in lib/bootstrap.dart
  throw UnimplementedError();
}

@Riverpod(keepAlive: true)
Flavor flavor(FlavorRef ref) {
  // Overriden in lib/bootstrap.dart
  throw UnimplementedError();
}
