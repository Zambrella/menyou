import 'package:flutter/material.dart';
import 'package:men_you/app_dependencies.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'selected_theme.g.dart';

@Riverpod(keepAlive: true)
class SelectedTheme extends _$SelectedTheme {
  static const kThemeKey = 'SAVED_THEME';

  // Initial build method to load the theme mode.
  @override
  Future<ThemeMode> build() async {
    try {
      final mode = await _loadThemeMode();
      return mode;
    } catch (e, st) {
      // Handle any errors that occur during loading
      ref.read(loggerProvider).e(
            'Error loading theme mode',
            error: e,
            stackTrace: st,
          );
      return ThemeMode.system;
    }
  }

  // Method to update the theme mode and persist it.
  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = AsyncData(themeMode);
    try {
      await _saveThemeMode(themeMode);
    } catch (e, st) {
      ref.read(loggerProvider).e(
            'Error saving theme mode',
            error: e,
            stackTrace: st,
          );
      state = AsyncError(e, st);
    }
  }

  // Private method to save the theme mode to shared preferences.
  Future<void> _saveThemeMode(ThemeMode themeMode) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setInt(kThemeKey, themeMode.index);
  }

  // Private method to load the theme mode from shared preferences.
  Future<ThemeMode> _loadThemeMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final savedModeValue = sharedPreferences.getInt(kThemeKey);
    if (savedModeValue == null) {
      return ThemeMode.system;
    }
    return ThemeMode.values[savedModeValue];
  }
}
