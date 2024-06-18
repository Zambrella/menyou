import 'package:flutter/material.dart';
import 'package:men_you/theme/common_theme.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
);

final lightTheme = commonTheme.copyWith(
  brightness: Brightness.light,
  colorScheme: colorScheme,
);
