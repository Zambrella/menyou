import 'package:flutter/material.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';

extension ThemeModeX on ThemeMode {
  String prettyPrint(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      ThemeMode.system => l10n.themeModeSystem,
      ThemeMode.light => l10n.themeModeLight,
      ThemeMode.dark => l10n.themeModeDark,
    };
  }
}
