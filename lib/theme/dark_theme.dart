import 'package:flutter/material.dart';
import 'package:men_you/theme/common_theme.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  brightness: Brightness.dark,
);

final darkTheme = commonTheme.copyWith(
  brightness: Brightness.dark,
  colorScheme: colorScheme,
  scaffoldBackgroundColor: Colors.black,
);
