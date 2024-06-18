import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'404 - Page not found'**
  String get pageNotFound;

  /// No description provided for @wrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Wrong password'**
  String get wrongPassword;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @userDisabled.
  ///
  /// In en, this message translates to:
  /// **'Your account has been disabled'**
  String get userDisabled;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'Account not found'**
  String get userNotFound;

  /// No description provided for @emailInUse.
  ///
  /// In en, this message translates to:
  /// **'Email is already in use'**
  String get emailInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak'**
  String get weakPassword;

  /// No description provided for @invalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Information provided is invalid'**
  String get invalidCredential;

  /// No description provided for @requiredReauthentication.
  ///
  /// In en, this message translates to:
  /// **'You need to reauthenticate'**
  String get requiredReauthentication;

  /// No description provided for @unknownAuthError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownAuthError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// No description provided for @subscriptionLengthOneWeek.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get subscriptionLengthOneWeek;

  /// No description provided for @subscriptionLengthOneMonth.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get subscriptionLengthOneMonth;

  /// No description provided for @subscriptionLengthTwoMonths.
  ///
  /// In en, this message translates to:
  /// **'Bi-Monthly'**
  String get subscriptionLengthTwoMonths;

  /// No description provided for @subscriptionLengthThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get subscriptionLengthThreeMonths;

  /// No description provided for @subscriptionLengthSixMonths.
  ///
  /// In en, this message translates to:
  /// **'Bi-Annual'**
  String get subscriptionLengthSixMonths;

  /// No description provided for @subscriptionLengthOneYear.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get subscriptionLengthOneYear;

  /// No description provided for @subscriptionLengthLifetime.
  ///
  /// In en, this message translates to:
  /// **'Lifetime'**
  String get subscriptionLengthLifetime;

  /// No description provided for @subscriptionLengthUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get subscriptionLengthUnknown;

  /// No description provided for @subscriptionLengthPerOneWeek.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get subscriptionLengthPerOneWeek;

  /// No description provided for @subscriptionLengthPerOneMonth.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get subscriptionLengthPerOneMonth;

  /// No description provided for @subscriptionLengthPerTwoMonths.
  ///
  /// In en, this message translates to:
  /// **'two months'**
  String get subscriptionLengthPerTwoMonths;

  /// No description provided for @subscriptionLengthPerThreeMonths.
  ///
  /// In en, this message translates to:
  /// **'three months'**
  String get subscriptionLengthPerThreeMonths;

  /// No description provided for @subscriptionLengthPerSixMonths.
  ///
  /// In en, this message translates to:
  /// **'six months'**
  String get subscriptionLengthPerSixMonths;

  /// No description provided for @subscriptionLengthPerOneYear.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get subscriptionLengthPerOneYear;

  /// No description provided for @subscriptionLengthPerLifetime.
  ///
  /// In en, this message translates to:
  /// **'lifetime'**
  String get subscriptionLengthPerLifetime;

  /// No description provided for @subscriptionLengthPerUnknown.
  ///
  /// In en, this message translates to:
  /// **'unknown'**
  String get subscriptionLengthPerUnknown;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
