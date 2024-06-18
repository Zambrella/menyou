import 'package:auth_core/auth_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';

extension ExceptionX<T> on AsyncError<T> {
  /// Returns a helpful, translated, error message for the exception attached to the [AsyncError].
  /// This is intended to be used for messages that will be shown to the user.
  /// This should be called in the widget and not in the business logic/provider.
  String errorMessage(BuildContext context) {
    final loc = AppLocalizations.of(context);
    if (error is Exception) {
      return switch (error as Exception) {
        final AuthException authException => switch (authException) {
            WrongPasswordException() => loc.wrongPassword,
            InvalidEmailException() => loc.invalidEmail,
            UserDisabledException() => loc.userDisabled,
            UserNotFoundException() => loc.userNotFound,
            EmailAlreadyInUseException() => loc.emailInUse,
            WeakPasswordException() => loc.weakPassword,
            InvalidCredentialException() => loc.invalidCredential,
            RequiresReauthenticationException() => loc.requiredReauthentication,
            UnknownAuthException() => loc.unknownAuthError,
            _ => loc.unknownAuthError,
          },
        final Exception exception => '${loc.unknownError} - ${formatException(exception)}',
      };
    } else {
      return error.toString();
    }
  }
}

String formatException(Exception exception) {
  var message = exception.toString();
  if (message.startsWith('Exception: ')) {
    message = message.replaceFirst('Exception: ', '');
  }
  return message;
}
