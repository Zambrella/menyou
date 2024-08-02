import 'package:flutter/material.dart';
import 'package:men_you/theme/page_transitions.dart';
import 'package:men_you/theme/theme_extensions.dart';

const Color primaryColor = Color.fromARGB(255, 0, 187, 6);
// const Color primaryColor = Color(0xffEAAD28);

final commonTheme = ThemeData(
  useMaterial3: true,
  extensions: const <ThemeExtension<dynamic>>[
    SpacingTheme(),
    ModalTheme(),
    DurationTheme(),
  ],
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.macOS: NoTransitionBuilder(),
    },
  ),
);

const List<Color> kAiColors = [
  Colors.green,
  Colors.orange,
  Colors.red,
];
