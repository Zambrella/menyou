// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNestedNavigation extends ConsumerStatefulWidget {
  const ScaffoldWithNestedNavigation({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<ScaffoldWithNestedNavigation> createState() => _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState extends ConsumerState<ScaffoldWithNestedNavigation> with SingleTickerProviderStateMixin {
  StatefulNavigationShell get navigationShell => widget.navigationShell;

  late final AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animation = Tween<double>(begin: 0, end: 80 + MediaQuery.of(context).padding.bottom).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutBack,
      ),
    );
    GoRouter.of(context).routerDelegate.addListener(onRouteChange);
  }

  void onRouteChange() {
    if (GoRouter.of(context).routerDelegate.currentConfiguration.pathParameters.containsKey('menuId')) {
      if (_controller.status == AnimationStatus.dismissed) _controller.forward();
    } else {
      if (_controller.status == AnimationStatus.completed) _controller.reverse();
    }
  }

  Future<void> animateBottomNavBarAway() async {}

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    GoRouter.of(context).routerDelegate.removeListener(onRouteChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: AnimatedBuilder(
        animation: _animation,
        builder: (context, _) {
          return Transform.translate(
            offset: Offset(0, _animation.value),
            child: NavigationBar(
              selectedIndex: navigationShell.currentIndex,
              destinations: const [
                NavigationDestination(label: 'Allergens', icon: Icon(Icons.food_bank)),
                NavigationDestination(label: 'Menus', icon: Icon(Icons.newspaper)),
                NavigationDestination(label: 'Settings', icon: Icon(Icons.settings)),
              ],
              onDestinationSelected: _goBranch,
              labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
            ),
          );
        },
      ),
    );
  }
}
