import 'package:data_privacy/data_privacy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/authentication/presentation/controllers/logout_controller.dart';
import 'package:men_you/repository_providers.dart';
import 'package:men_you/routing/app_router.dart';
import 'package:men_you/theme/selected_theme.dart';
import 'package:men_you/theme/theme_extensions.dart';
import 'package:go_router/go_router.dart';

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
    ref.listen(logoutControllerProvider, (prev, next) {
      if (next is AsyncData) {
        print('User logged out');
        // context.goNamed(AppRoute.login.name);
      }

      if (next is AsyncLoading) {
        print('Loading...');
      }
    });

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
              onPressed: () async {
                final settings = await showConsentExplainer(
                  context,
                  ConsentExplainerConfig(
                    privacyPolicyUrl: Uri.parse('https://google.com'),
                    title: 'Your Privacy Matters',
                    content: const Text('Please accept it helps us both'),
                    acceptButtonText: 'Agree',
                    declineButtonText: 'Decline',
                    continueButtonText: 'Continue',
                  ),
                );
                if (settings != null) {
                  await ref.read(dataPrivacyRepositoryProvider).savePrivacySettings(settings);
                }
              },
              child: const Text('Enable tracking'),
            ),
            ElevatedButton(
              onPressed: () {
                context.goNamed(AppRoute.details.name);
              },
              child: const Text('Details Page'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(selectedThemeProvider.notifier).setThemeMode(
                      ref.read(selectedThemeProvider).requireValue == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark,
                    );
              },
              child: const Text('Switch theme'),
            ),
            Padding(
              padding: EdgeInsets.all(context.theme.appSpacing.medium),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'This is a text field',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Text Button'),
            ),
            Switch(
              value: true,
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
