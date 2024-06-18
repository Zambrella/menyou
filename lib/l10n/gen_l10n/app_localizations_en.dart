import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get pageNotFound => '404 - Page not found';

  @override
  String get wrongPassword => 'Wrong password';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get userDisabled => 'Your account has been disabled';

  @override
  String get userNotFound => 'Account not found';

  @override
  String get emailInUse => 'Email is already in use';

  @override
  String get weakPassword => 'Password is too weak';

  @override
  String get invalidCredential => 'Information provided is invalid';

  @override
  String get requiredReauthentication => 'You need to reauthenticate';

  @override
  String get unknownAuthError => 'An unknown error occurred';

  @override
  String get unknownError => 'An unknown error occurred';

  @override
  String get subscriptionLengthOneWeek => 'Weekly';

  @override
  String get subscriptionLengthOneMonth => 'Monthly';

  @override
  String get subscriptionLengthTwoMonths => 'Bi-Monthly';

  @override
  String get subscriptionLengthThreeMonths => 'Quarterly';

  @override
  String get subscriptionLengthSixMonths => 'Bi-Annual';

  @override
  String get subscriptionLengthOneYear => 'Annual';

  @override
  String get subscriptionLengthLifetime => 'Lifetime';

  @override
  String get subscriptionLengthUnknown => 'Unknown';

  @override
  String get subscriptionLengthPerOneWeek => 'week';

  @override
  String get subscriptionLengthPerOneMonth => 'month';

  @override
  String get subscriptionLengthPerTwoMonths => 'two months';

  @override
  String get subscriptionLengthPerThreeMonths => 'three months';

  @override
  String get subscriptionLengthPerSixMonths => 'six months';

  @override
  String get subscriptionLengthPerOneYear => 'year';

  @override
  String get subscriptionLengthPerLifetime => 'lifetime';

  @override
  String get subscriptionLengthPerUnknown => 'unknown';
}
