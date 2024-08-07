import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

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
    Locale('en')
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

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

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

  /// No description provided for @welcomeHeaderPart1.
  ///
  /// In en, this message translates to:
  /// **'Eat out with '**
  String get welcomeHeaderPart1;

  /// No description provided for @welcomeHeaderPart2.
  ///
  /// In en, this message translates to:
  /// **'confidence'**
  String get welcomeHeaderPart2;

  /// No description provided for @welcomeSubheader.
  ///
  /// In en, this message translates to:
  /// **'Take a photo of a restaurant menu and get allergen information in seconds'**
  String get welcomeSubheader;

  /// No description provided for @welcomeCTA.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get welcomeCTA;

  /// No description provided for @aiWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get aiWarningTitle;

  /// No description provided for @aiWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'MenYou uses AI and can sometimes generate incorrect or incomplete information. If you are not sure about the results, please make sure to ask the kitchen.'**
  String get aiWarningMessage;

  /// No description provided for @aiWarningCTA.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get aiWarningCTA;

  /// No description provided for @aiWarningDontShowAgain.
  ///
  /// In en, this message translates to:
  /// **'Do not show this message again'**
  String get aiWarningDontShowAgain;

  /// No description provided for @navigationMenus.
  ///
  /// In en, this message translates to:
  /// **'Menus'**
  String get navigationMenus;

  /// No description provided for @navigationAllergens.
  ///
  /// In en, this message translates to:
  /// **'Allergens'**
  String get navigationAllergens;

  /// No description provided for @navigationSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navigationSettings;

  /// No description provided for @emptyMenus.
  ///
  /// In en, this message translates to:
  /// **'No menus found'**
  String get emptyMenus;

  /// No description provided for @emptyMenusCTA.
  ///
  /// In en, this message translates to:
  /// **'Add a menu by pressing the + button'**
  String get emptyMenusCTA;

  /// No description provided for @addMenuTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add a new menu'**
  String get addMenuTooltip;

  /// No description provided for @allergenStatusSafe.
  ///
  /// In en, this message translates to:
  /// **'Fine'**
  String get allergenStatusSafe;

  /// No description provided for @allergenStatusIntolerant.
  ///
  /// In en, this message translates to:
  /// **'Intolerant'**
  String get allergenStatusIntolerant;

  /// No description provided for @allergenStatusAllergic.
  ///
  /// In en, this message translates to:
  /// **'Allergic'**
  String get allergenStatusAllergic;

  /// No description provided for @celery.
  ///
  /// In en, this message translates to:
  /// **'Celery'**
  String get celery;

  /// No description provided for @celeryDescription.
  ///
  /// In en, this message translates to:
  /// **'This includes celery stalks, leaves, seeds and the root called celeriac.'**
  String get celeryDescription;

  /// No description provided for @gluten.
  ///
  /// In en, this message translates to:
  /// **'Gluten'**
  String get gluten;

  /// No description provided for @glutenDescription.
  ///
  /// In en, this message translates to:
  /// **'Wheat, rye, barley and some oats.'**
  String get glutenDescription;

  /// No description provided for @crustacean.
  ///
  /// In en, this message translates to:
  /// **'Crustacean'**
  String get crustacean;

  /// No description provided for @crustaceanDescription.
  ///
  /// In en, this message translates to:
  /// **'Crabs, lobster, prawns and scampi are crustaceans.'**
  String get crustaceanDescription;

  /// No description provided for @egg.
  ///
  /// In en, this message translates to:
  /// **'Egg'**
  String get egg;

  /// No description provided for @eggDescription.
  ///
  /// In en, this message translates to:
  /// **'Eggs are often found in cakes, some meat products, mayonnaise, mousses, pasta, quiche, sauces and pastries'**
  String get eggDescription;

  /// No description provided for @fish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get fish;

  /// No description provided for @fishDescription.
  ///
  /// In en, this message translates to:
  /// **'You will find this in some fish sauces, pizzas, relishes, salad dressings, stock cubes and Worcestershire sauce.'**
  String get fishDescription;

  /// No description provided for @lupin.
  ///
  /// In en, this message translates to:
  /// **'Lupin'**
  String get lupin;

  /// No description provided for @lupinDescription.
  ///
  /// In en, this message translates to:
  /// **'Lupin is a type of legume that can be used in flour.'**
  String get lupinDescription;

  /// No description provided for @milk.
  ///
  /// In en, this message translates to:
  /// **'Milk'**
  String get milk;

  /// No description provided for @milkDescription.
  ///
  /// In en, this message translates to:
  /// **'Milk is a common ingredient in butter, cheese, cream, milk powders and yoghurt.'**
  String get milkDescription;

  /// No description provided for @mollusc.
  ///
  /// In en, this message translates to:
  /// **'Mollusc'**
  String get mollusc;

  /// No description provided for @molluscDescription.
  ///
  /// In en, this message translates to:
  /// **'These include mussels, land snails, squid and whelks, but can also be found in oyster sauce or as an ingredient in fish stews.'**
  String get molluscDescription;

  /// No description provided for @mustard.
  ///
  /// In en, this message translates to:
  /// **'Mustard'**
  String get mustard;

  /// No description provided for @mustardDescription.
  ///
  /// In en, this message translates to:
  /// **'Liquid mustard, mustard powder and mustard seeds fall into this category.'**
  String get mustardDescription;

  /// No description provided for @nuts.
  ///
  /// In en, this message translates to:
  /// **'Nuts'**
  String get nuts;

  /// No description provided for @nutsDescription.
  ///
  /// In en, this message translates to:
  /// **'Nuts are often found in bread, biscuits, crackers, desserts, nut powders (often used in Asian curries), stir-fried dishes, ice cream, marzipan (almond paste), nut oils and sauces.'**
  String get nutsDescription;

  /// No description provided for @peanuts.
  ///
  /// In en, this message translates to:
  /// **'Peanuts'**
  String get peanuts;

  /// No description provided for @peanutsDescription.
  ///
  /// In en, this message translates to:
  /// **'Peanuts are often used as an ingredient in biscuits, cakes, curries, desserts, sauces (such as satay sauce), as well as in groundnut oil and peanut flour.'**
  String get peanutsDescription;

  /// No description provided for @sesame.
  ///
  /// In en, this message translates to:
  /// **'Sesame'**
  String get sesame;

  /// No description provided for @sesameDescription.
  ///
  /// In en, this message translates to:
  /// **'Sesame seeds are found in bread, breadsticks, houmous, sesame oil and tahini (sesame paste).'**
  String get sesameDescription;

  /// No description provided for @soya.
  ///
  /// In en, this message translates to:
  /// **'Soya'**
  String get soya;

  /// No description provided for @soyaDescription.
  ///
  /// In en, this message translates to:
  /// **'Often found in bean curd, edamame beans, miso paste, textured soya protein, soya flour or tofu, soya is a staple ingredient in oriental food.'**
  String get soyaDescription;

  /// No description provided for @sulphurDioxide.
  ///
  /// In en, this message translates to:
  /// **'Sulphur Dioxide'**
  String get sulphurDioxide;

  /// No description provided for @sulphurDioxideDescription.
  ///
  /// In en, this message translates to:
  /// **'This is used as a preservative in dried fruit, meat products, soft drinks and vegetables as well as in wine and beer.'**
  String get sulphurDioxideDescription;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @askMeSomething.
  ///
  /// In en, this message translates to:
  /// **'Ask me something about'**
  String get askMeSomething;

  /// No description provided for @chefBot.
  ///
  /// In en, this message translates to:
  /// **'Chef Bot'**
  String get chefBot;

  /// No description provided for @chefBotIsTyping.
  ///
  /// In en, this message translates to:
  /// **'Chef Bot is typing...'**
  String get chefBotIsTyping;

  /// No description provided for @you.
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// No description provided for @askAQuestion.
  ///
  /// In en, this message translates to:
  /// **'Ask a question'**
  String get askAQuestion;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @vegetarian.
  ///
  /// In en, this message translates to:
  /// **'Vegetarian'**
  String get vegetarian;

  /// No description provided for @vegan.
  ///
  /// In en, this message translates to:
  /// **'Vegan'**
  String get vegan;

  /// No description provided for @potentialAllergens.
  ///
  /// In en, this message translates to:
  /// **'Potential allergens'**
  String get potentialAllergens;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMore;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take photo'**
  String get takePhoto;

  /// No description provided for @selectPhoto.
  ///
  /// In en, this message translates to:
  /// **'Select photo'**
  String get selectPhoto;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @build.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get build;

  /// No description provided for @menuName.
  ///
  /// In en, this message translates to:
  /// **'Menu name'**
  String get menuName;

  /// No description provided for @enterMenuName.
  ///
  /// In en, this message translates to:
  /// **'Enter menu name'**
  String get enterMenuName;

  /// No description provided for @saveMenu.
  ///
  /// In en, this message translates to:
  /// **'Save menu'**
  String get saveMenu;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
