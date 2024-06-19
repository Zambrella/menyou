import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:men_you/authentication/presentation/controllers/logout_controller.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/routing/app_router.dart';
import 'package:men_you/theme/selected_theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            Text('List of previous menus...'),
            ElevatedButton(
              onPressed: () {
                final menu = RestaurantMenu.empty();
                context.goNamed(
                  AppRoute.menu.name,
                  pathParameters: {'menuId': menu.id},
                  extra: menu,
                );
              },
              child: const Text('New Menu'),
            ),
          ],
        ),
      ),
    );
  }
}
