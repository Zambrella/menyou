import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/authentication/presentation/controllers/logout_controller.dart';
import 'package:men_you/theme/selected_theme.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              await ref.read(logoutControllerProvider.notifier).logout();
            },
            child: const Text('Logout'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(selectedThemeProvider.notifier).setThemeMode(
                    ref.read(selectedThemeProvider).requireValue == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
                  );
            },
            child: const Text('Switch theme'),
          ),
        ],
      ),
    );
  }
}
