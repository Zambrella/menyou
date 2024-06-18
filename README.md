# Flutter Starter Template

![coverage][coverage_badge]
This template is meant as a good starting point for any app. It includes:
- routing
- initialization
- authentication
- logging
- exception reporting
- analytics
- purchases
- flavors
- tests

It makes use of other packages defined in this mono-repo.


## Deep Links 🔗
Just follow [this](https://codewithandrea.com/articles/flutter-deep-links/) awesome guide. 

Template app has been tested and works with deep links.

---

## App Icon 📱
TODO: Update this documentation with learnings and any pitfalls.

Use [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package (which supports flavors).

Other options:
- https://pub.dev/packages/icons_launcher

---

## Splash Screen 💦
TODO: Update this documentation with learnings and any pitfalls.

Use [flutter_native_splash](https://pub.dev/packages/flutter_native_splash) package (which supports flavors).

---

## Environment variables 🌱
It is expected that there are 3 `.env` files:
- `.development.env`
- `.staging.env`
- `.production.env`

These are not checked into source control.

[flutter_dotenv](https://pub.dev/packages/flutter_dotenv) package is used to load the relevant file during initialization. Variables can be accessed like so:
```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';
dotenv.env['VAR_NAME'];
```

Secrets and API keys should ideally **not** be stored in envrionment variables. Although better than coding them into a `String` they can still be accessed by someone with access to the compiled app. It is better to never give the client access to the keys and handle any code that requires the keys in a trusted environement (e.g. a server).

---

## Theming 🌈
Theming is all handled in the `lib/theme` directory.

A common theme is defined in `common_theme.dart` which handles all theming that isn't related to colours.

There is then `light_theme.dart` and `dark_theme.dart` which copies the `common_theme` and adds the relevant colours and brightness. The `MaterialApp` then uses these themes.

NOTE: This might not be the best way to do it so it might change in the future

### Extensions
Theme extensions provide a robust mechanism to extend and customize the default theming capabilities. Currently implemented are:
- `SpacingTheme` - Sizes that will mostly be used for padding and gap spacing. These could probably just be constants.
- `DurationTheme` - Different durations that can be used by animations so the app uses consistent timings throughout.
- `ModalTheme` - ???

### Text scale factor clamper
This widget wraps the entire app and prevents the font from getting too big or small when the user has adjusted the font size in the OS settings. Although it would be ideal to not have to do this, some apps just can't handle it if the font gets too large.


---

## CI/CD 🚝

---

## Exceptions ⚠️
There is an extension for `AsyncError` which will loop through all known `Exception` types and create a helpful error message for the user.
When creating new exceptions, you should add a suitable error message to the relevant `.arb` files and add it as an option in `app_exceptions.dart`.

There is also a helpful function that will take a plain `Exception` type and remove the `Exception: ` prefix and return it as a `String`.

---

## Flavors 😋

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Flutter Starter Template works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
$ flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

I was having issues where the generated file would be in the `.dart-tool` directory so I followed [this SO answer](https://stackoverflow.com/a/78257261) and it worked.

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

2. Then add a new key/value and description

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    },
    "helloWorld": "Hello World",
    "@helloWorld": {
        "description": "Hello World Text"
    }
}
```

3. Use the new string

```dart
import 'package:men_you/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
	<array>
		<string>en</string>
		<string>es</string>
	</array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

2. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

```sh
flutter gen-l10n --arb-dir="lib/l10n/arb"
```

Alternatively, run `flutter run` and code generation will take place automatically.

## Notes 📝


[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
