import 'package:flutter/material.dart';
import 'package:men_you/theme/page_transitions.dart';
import 'package:men_you/theme/theme_extensions.dart';

const Color primaryColor = Color(0xFF9544AE);

final textTheme = const TextTheme().apply();

const buttonTheme = ButtonThemeData();

final elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(),
);

final outlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(),
);

final textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(),
);

const dividerTheme = DividerThemeData();

const textSelectionTheme = TextSelectionThemeData();

const inputTheme = InputDecorationTheme();

final commonTheme = ThemeData(
  useMaterial3: true,
  extensions: const <ThemeExtension<dynamic>>[
    SpacingTheme(),
    ModalTheme(),
    DurationTheme(),
  ],
  textTheme: textTheme,
  primaryTextTheme: textTheme,
  // fontFamily: 'Fondamento',
  buttonTheme: buttonTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  outlinedButtonTheme: outlinedButtonTheme,
  textButtonTheme: textButtonTheme,
  dividerTheme: dividerTheme,
  inputDecorationTheme: inputTheme,
  textSelectionTheme: textSelectionTheme,
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: NoTransitionBuilder(),
    },
  ),
);
