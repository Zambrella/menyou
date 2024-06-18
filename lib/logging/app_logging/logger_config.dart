import 'dart:async';

import 'package:error_logging_core/error_logging_core.dart';
import 'package:flutter/foundation.dart';
import 'package:men_you/flavors.dart';
import 'package:logger/logger.dart';

class AppLogFilter extends LogFilter {
  AppLogFilter(this._flavor);

  final Flavor _flavor;

  @override
  bool shouldLog(LogEvent event) {
    // Log everything in dev and staging
    if (_flavor == Flavor.dev || _flavor == Flavor.staging) {
      return true;
      // Log only errors in production
    } else if (event.level.value >= Level.error.value) {
      return true;
    } else {
      return false;
    }
  }
}

class AppLogOutput extends LogOutput {
  AppLogOutput(this._loggingRepository);

  final ErrorLoggingRepository _loggingRepository;

  @override
  void output(OutputEvent event) {
    // Log exceptions to the error logging repository
    if (event.level.value >= Level.error.value) {
      unawaited(
        _loggingRepository
            .logException(
          event.origin.message.toString(),
          error: event.origin.error,
          stackTrace: event.origin.stackTrace,
          isFatal: event.level.value >= Level.fatal.value,
        )
            .catchError((_) {
          debugPrint('Failed to log exception');
        }),
      );
    }
    // Print all logs to the console if in debug mode
    if (kDebugMode) {
      for (final line in event.lines) {
        debugPrint(line);
      }
    }
  }
}
