import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:men_you/allergens/presentation/pages/allergens_page.dart';
import 'package:men_you/authentication/providers/authentication_providers.dart';
import 'package:men_you/home/presentation/home_page.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/pages/menu_page.dart';
import 'package:men_you/routing/go_router_refresh_stream.dart';
import 'package:men_you/routing/not_found_screen.dart';
import 'package:men_you/welcome/presentation/pages/welcome_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');

enum AppRoute {
  welcome,
  home,
  menu,
  allergens,
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: GoRouterRefreshStream(ref.watch(authStateChangesProvider.stream)),
    redirect: (context, state) {
      final path = state.uri.path;
      final isLoggedIn = ref.read(currentUserProvider) != null;

      // Redirect to home page if navigating to login pages while logged in
      if (isLoggedIn) {
        if (path.startsWith('/welcome')) {
          return '/home';
        }
      }

      // Redirect to login page if navigating to protected pages while not logged in
      if (!isLoggedIn) {
        if (path.startsWith('/welcome')) {
          return null;
        } else {
          return '/welcome';
        }
      }

      // No redirect
      return null;
    },
    routes: [
      GoRoute(
        path: '/startup',
        pageBuilder: (context, state) {
          return const NoTransitionPage(child: SizedBox.shrink());
        },
      ),
      GoRoute(
        path: '/welcome',
        name: AppRoute.welcome.name,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const WelcomePage(),
        ),
      ),
      GoRoute(
        path: '/home',
        name: AppRoute.home.name,
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: const HomePage(),
        ),
        routes: [
          GoRoute(
            path: 'menus/:menuId',
            name: AppRoute.menu.name,
            pageBuilder: (context, state) {
              final menuId = state.pathParameters['menuId'];
              if (menuId == null) {
                return const NoTransitionPage(
                  child: NotFoundScreen(),
                );
              }
              final restaurantMenu = state.extra as RestaurantMenu?;
              return MaterialPage<void>(
                key: state.pageKey,
                child: MenuPage(
                  menuId: menuId,
                  restaurantMenu: restaurantMenu,
                ),
              );
            },
          ),
          GoRoute(
            path: 'allergens',
            name: AppRoute.allergens.name,
            pageBuilder: (context, state) {
              return MaterialPage<void>(
                key: state.pageKey,
                child: const AllergensPage(),
              );
            },
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) => const NoTransitionPage(
      child: NotFoundScreen(),
    ),
  );
}

extension GoRouterExtension on GoRouter {
  // Clear the stack and navigate to a new location
  void clearStackAndNavigate(String location) {
    while (canPop()) {
      pop();
    }
    pushReplacement(location);
  }
}
