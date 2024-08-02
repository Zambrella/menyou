import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/app_dependencies.dart';
import 'package:men_you/authentication/providers/authentication_providers.dart';
import 'package:men_you/authentication/providers/login_provider.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';
import 'package:men_you/routing/app_router.dart';
import 'package:men_you/theme/dark_theme.dart';
import 'package:men_you/theme/light_theme.dart';
import 'package:men_you/theme/selected_theme.dart';
import 'package:men_you/theme/text_scale_factor_clamper.dart';
import 'package:toastification/toastification.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen<AsyncValue<void>>(
        serviceInitialisationProvider,
        (_, state) {
          if (state.hasValue || state.hasError) {
            FlutterNativeSplash.remove();
          }
        },
      )
      ..listen(authStateChangesProvider, (prev, state) async {
        if (state.hasValue && state.asData?.value != null) {
          final userId = state.asData!.value!.id;
          await ref.read(loginProvider(userId).future);
        }
      });

    final initDependencies = ref.watch(serviceInitialisationProvider);
    final goRouter = ref.watch(goRouterProvider);
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp.router(
          routerConfig: goRouter,
          theme: lightTheme.copyWith(colorScheme: lightDynamic?.harmonized()),
          darkTheme: darkTheme.copyWith(colorScheme: darkDynamic?.harmonized()),
          themeMode: ref.watch(selectedThemeProvider).maybeWhen(
                orElse: () => ThemeMode.system,
                data: (themeMode) => themeMode,
              ),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) {
            // Wrap with InheritedWidgets here if needed. E.g. One that overrides the text scale factor
            return initDependencies.when(
              skipLoadingOnRefresh: false,
              data: (_) => ToastificationConfigProvider(
                config: const ToastificationConfig(
                  alignment: Alignment.topCenter,
                ),
                child: TextScaleFactorClamper(
                  child: child!,
                ),
              ),
              // Loading screen is handled by the native splash screen on the first load.
              // If there's an error and the user refreshes, the loading screen will be shown.
              loading: () => const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              error: (_, __) {
                // Logging the error is handled by the provider observer.
                return const AppStartupErrorWidget();
              },
            );
          },
        );
      },
    );
  }
}

class AppStartupErrorWidget extends ConsumerWidget {
  const AppStartupErrorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Unexpected error!\nPlease restart the app.',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(appDependenciesProvider);
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
