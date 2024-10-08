import 'package:animated_list_plus/animated_list_plus.dart';
import 'package:animated_list_plus/transitions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:men_you/account/providers/account_repository_provider.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/controllers/menus_page_controller.dart';
import 'package:men_you/menu/presentation/widgets/consent_dialog.dart';
import 'package:men_you/menu/presentation/widgets/restaurant_menu_card.dart';
import 'package:men_you/routing/app_router.dart';
import 'package:men_you/theme/common_theme.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenusPage extends ConsumerStatefulWidget {
  const MenusPage({super.key});

  @override
  ConsumerState<MenusPage> createState() => _MenusPageState();
}

class _MenusPageState extends ConsumerState<MenusPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showConsentDialog(context);
    });
  }

  Future<void> showConsentDialog(BuildContext context) async {
    final doNotShowAiWarningAgain = await ref.read(accountRepositoryProvider).getDoNotShowAiWarningAgain();
    // Wait for the page to be fully loaded before showing the dialog
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!doNotShowAiWarningAgain && context.mounted) {
      final answer = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const ConsentDialog();
        },
      );
      if (answer ?? false) {
        await ref.read(accountRepositoryProvider).saveDoNotShowAiWarningAgain();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navigationMenus),
        actions: [
          IconButton(
            tooltip: l10n.addMenuTooltip,
            icon: Icon(
              Icons.add_circle,
              color: context.theme.colorScheme.primary,
            ),
            onPressed: () {
              final menu = RestaurantMenu.empty();
              context.goNamed(
                AppRoute.menu.name,
                pathParameters: {'menuId': menu.id},
                extra: menu,
              );
            },
          ),
        ],
      ),
      body: ref.watch(menusPageControllerProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Error: $error')),
            data: (menus) {
              if (menus.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.emptyMenus,
                      style: context.theme.textTheme.headlineMedium?.copyWith(color: context.theme.colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      l10n.emptyMenusCTA,
                      style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
              return MenusListView(
                menus: menus,
              );
            },
          ),
    );
  }
}

class MenusListView extends ConsumerStatefulWidget {
  const MenusListView({
    required this.menus,
    super.key,
  });

  final List<RestaurantMenu> menus;

  @override
  ConsumerState<MenusListView> createState() => _MenusListViewState();
}

class _MenusListViewState extends ConsumerState<MenusListView> with SingleTickerProviderStateMixin {
  List<RestaurantMenu> get menus => widget.menus;

  late final Duration _animationDuration = Duration(milliseconds: menus.length * 350);

  late final AnimationController _animationController;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
    );
    _animations = [];
    const overlapFraction = 0.5;

    for (var i = 0; i < menus.length; i++) {
      final start = (i * (1 - overlapFraction)) / menus.length;
      final end = ((i + 1) * (1 - overlapFraction) + overlapFraction) / menus.length;

      final curvedAnimation = CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          start,
          end.clamp(0.0, 1.0), // Ensure the end value does not exceed 1.0
          curve: Curves.easeIn,
        ),
      );
      _animations.add(Tween<double>(begin: 0, end: 1).animate(curvedAnimation));
    }

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // https://pub.dev/packages/animated_list_plus
    return ImplicitlyAnimatedList(
      items: menus,
      padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: MediaQuery.of(context).padding.bottom + 8),
      areItemsTheSame: (oldItem, newItem) => oldItem.id == newItem.id,
      itemBuilder: (context, animation, item, index) {
        final menu = item;
        return SizeFadeTransition(
          sizeFraction: 0.7,
          curve: Curves.easeInOut,
          animation: animation,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              final itemIndex = menus.indexOf(menu);
              final animationValue = (itemIndex < _animations.length && itemIndex > 0) ? _animations[itemIndex].value : 1.0;
              return Transform.translate(
                offset: Offset(0, -50 * (1 - animationValue)),
                child: Opacity(
                  opacity: animationValue,
                  child: RestaurantMenuCard(
                    menu: menu,
                    highlightColor: kAiColors[itemIndex % kAiColors.length],
                    // highlightColor: context.theme.colorScheme.primary,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
