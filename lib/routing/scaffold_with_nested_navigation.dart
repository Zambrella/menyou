// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:men_you/theme/theme_extensions.dart';

const kBottomNavBarHeight = 80;

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

  /// Forward hides the navbar, reverse shows it
  late final AnimationController _controller;
  late Animation<double> _animation;
  late bool navbarIsHidden = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _animation = Tween<double>(begin: 0, end: kBottomNavBarHeight + MediaQuery.of(context).padding.bottom).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    GoRouter.of(context).routerDelegate.addListener(_onRouteChange);
  }

  void _onRouteChange() {
    if (GoRouter.of(context).routerDelegate.currentConfiguration.pathParameters.containsKey('menuId')) {
      navbarIsHidden = true;
    } else {
      navbarIsHidden = false;
    }

    if (navbarIsHidden) {
      if (_controller.status == AnimationStatus.dismissed) _controller.forward();
    } else {
      if (_controller.status == AnimationStatus.completed) _controller.reverse();
    }
  }

  bool _onScroll(ScrollNotification notification) {
    // Do nothing if the navbar is hidden
    if (navbarIsHidden) {
      return false;
    }

    // Could also be [ScrollStartNotification] or [ScrollEndNotification] .
    if (notification is ScrollUpdateNotification) {
      // Do nothing on overscroll
      final isOverscroll = notification.metrics.pixels <= 0 || notification.metrics.pixels == notification.metrics.maxScrollExtent;
      if (isOverscroll) {
        return false;
      }
      // At the very top, show the navbar
      // Very bottom already handled by else branch
      if (notification.metrics.pixels == 0 && _controller.status == AnimationStatus.completed) {
        _controller.reverse();
      } else {
        // Scrolling down
        if (notification.scrollDelta! > 0 && _controller.status == AnimationStatus.dismissed) {
          _controller.forward();
          // Scrolling up
        } else if (notification.scrollDelta! < 0 && _controller.status == AnimationStatus.completed) {
          _controller.reverse();
        }
      }
    }
    return false;
  }

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _onScroll,
      child: Scaffold(
        extendBody: true,
        body: widget.navigationShell,
        bottomNavigationBar: AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Transform.translate(
              offset: Offset(0, _animation.value),
              child: NavigationBar(
                selectedIndex: navigationShell.currentIndex,
                destinations: const [
                  NavigationDestination(
                    label: 'Allergens',
                    icon: NavbarIcon.unselected(
                      iconPath: 'assets/icons/allergens.svg',
                    ),
                    selectedIcon: NavbarIcon.selected(
                      iconPath: 'assets/icons/allergens_selected.svg',
                    ),
                  ),
                  NavigationDestination(
                    label: 'Menus',
                    icon: NavbarIcon.unselected(
                      iconPath: 'assets/icons/menu.svg',
                    ),
                    selectedIcon: NavbarIcon.selected(
                      iconPath: 'assets/icons/menu_selected.svg',
                    ),
                  ),
                  NavigationDestination(
                    label: 'Settings',
                    icon: NavbarIcon.unselected(
                      iconPath: 'assets/icons/settings.svg',
                    ),
                    selectedIcon: NavbarIcon.selected(
                      iconPath: 'assets/icons/settings_selected.svg',
                    ),
                  ),
                ],
                onDestinationSelected: _goBranch,
                labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
              ),
            );
          },
        ),
      ),
    );
  }
}

class NavbarIcon extends StatelessWidget {
  const NavbarIcon.unselected({
    required this.iconPath,
    this.isSelected = false,
    super.key,
  });
  const NavbarIcon.selected({
    required this.iconPath,
    this.isSelected = true,
    super.key,
  });

  final String iconPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      iconPath,
      width: 24,
      colorFilter: isSelected
          ? null
          : ColorFilter.mode(
              context.theme.colorScheme.onSurface,
              BlendMode.srcIn,
            ),
    );
  }
}
