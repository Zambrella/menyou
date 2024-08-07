import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/app_dependencies.dart';
import 'package:men_you/authentication/presentation/controllers/logout_controller.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';
import 'package:men_you/settings/utils/theme_mode_extensions.dart';
import 'package:men_you/theme/selected_theme.dart';
import 'package:men_you/theme/theme_extensions.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navigationSettings),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          ListTile(
            iconColor: context.theme.colorScheme.primary,
            leading: const Icon(Icons.color_lens_outlined),
            title: Text(l10n.theme),
            trailing: DropdownButton<ThemeMode>(
              underline: const SizedBox.shrink(),
              dropdownColor: context.theme.colorScheme.surfaceContainer,
              value: ref.watch(selectedThemeProvider).requireValue,
              style: context.theme.textTheme.bodyLarge?.copyWith(color: context.theme.colorScheme.onSurface),
              items: ThemeMode.values
                  .map(
                    (mode) => DropdownMenuItem<ThemeMode>(
                      value: mode,
                      child: Text(mode.prettyPrint(context)),
                    ),
                  )
                  .toList(),
              onChanged: (themeMode) {
                if (themeMode != null) {
                  ref.read(selectedThemeProvider.notifier).setThemeMode(themeMode);
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: context.theme.colorScheme.primary),
            ),
            onPressed: () async {
              await ref.read(logoutControllerProvider.notifier).logout();
            },
            child: Text(l10n.logout),
          ),
          const SizedBox(height: 4),
          Text(
            '${l10n.version}: ${ref.read(appDependenciesProvider).requireValue.packageInfo.version} | ${l10n.build}: ${ref.read(appDependenciesProvider).requireValue.packageInfo.buildNumber}',
            style: context.theme.textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onSurface),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
