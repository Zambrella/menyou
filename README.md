<img src="assets/icons/men-you-app-icon.png" width="150">

# MenYou
Watch the demo video [here](https://youtu.be/eOVe7t-xohY).

"Have you ever struggled deciding what to eat at a restaurant? How about when you have intolerances or allergies? Eating out becomes such a nightmare, it would be easier to stay at home! This is where MenYou comes in. A new mobile app, powered by AI, to revolutionise eating out for those with intolerances and allergies."

## Running the app
> [!WARNING]  
> Android will only work when running in PROD as I have not set up multiple Firebase projects.
> See [Flavors](#flavors) for more info.
1. Clone the repo
2. Run `flutter run --flavor production --target lib/main_production.dart`
3. Explore

---

## Environment variables 🌱
It is expected that there are 3 `.env` files:
- `.development.env`
- `.staging.env`
- `.production.env`

These are not checked into source control.

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
---

## TODO
- [ ] Extract photo loading custom painter to its own useful widget
- [ ] Shader that affects background image as circle points move through it
- [ ] Shader that slowly un-blurs (or something similar) the picture
- [ ] Split menu items into courses
- [ ] Fix the bottom nav edge cases not showing/hiding correctly when scrolling
- [ ] Ask the user if they want to save the menu if they haven’t already when navigating away
- [ ] Add location to menu
- [ ] Generate an image of the menu item. Will require using vertex api - https://console.cloud.google.com/vertex-ai/publishers/google/model-garden/imagegeneration?project=stash-hub
- [ ] Animate app bar title when changing location
- [ ] Add support for using on-device LLMs
- [ ] Add support for tablets

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


[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
