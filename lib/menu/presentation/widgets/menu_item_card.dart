import 'dart:math';
import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/pages/menu_item_details_page.dart';
import 'package:men_you/menu/presentation/widgets/menu_item_allergens.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenuItemCard extends ConsumerStatefulWidget {
  const MenuItemCard({
    required this.menuItem,
    super.key,
  });

  final MenuItem menuItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends ConsumerState<MenuItemCard> with TickerProviderStateMixin {
  static const _loadingAnimationDuration = Duration(milliseconds: 5000);
  static const _loadingCompleteAnimationDuration = Duration(milliseconds: 500);
  static const _animatedSizeDuration = Duration(milliseconds: 500);

  late final AnimationController _loadingAnimationController;
  late final Animation<double> _loadingAnimation;
  late final AnimationController _loadingCompleteAnimationController;
  late final Animation<double> _loadingCompleteAnimation;

  @override
  void initState() {
    super.initState();
    _loadingAnimationController = AnimationController(
      vsync: this,
      duration: _loadingAnimationDuration,
    );
    _loadingAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _loadingAnimationController,
        curve: Curves.linear,
      ),
    );
    _loadingCompleteAnimationController = AnimationController(
      vsync: this,
      duration: _loadingCompleteAnimationDuration,
    );
    _loadingCompleteAnimation = CurvedAnimation(
      parent: _loadingCompleteAnimationController,
      curve: Curves.easeInOut,
    );
    if (widget.menuItem is UnprocessedMenuItem) {
      _loadingAnimationController.repeat();
    } else {
      _loadingCompleteAnimationController.value = _loadingAnimationController.upperBound;
    }
  }

  Future<void> loadingComplete() async {
    _loadingAnimationController.stop();
    await _loadingCompleteAnimationController.forward();
  }

  @override
  void didUpdateWidget(covariant MenuItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.menuItem is ProcessedMenuItem && oldWidget.menuItem is UnprocessedMenuItem) {
      // Stop the loading animation
      // Transform into a different style of card? (this could be handled implicitly by the widget itself though)
      loadingComplete();
    }
  }

  @override
  void dispose() {
    _loadingAnimationController.dispose();
    _loadingCompleteAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChipTheme(
      data: ChipThemeData(
        backgroundColor: context.theme.colorScheme.secondaryContainer,
        brightness: context.theme.brightness,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: AnimatedBuilder(
                animation: _loadingAnimation,
                builder: (context, _) {
                  return AnimatedBuilder(
                    animation: _loadingCompleteAnimation,
                    builder: (context, _) {
                      return Opacity(
                        opacity: (_loadingCompleteAnimation.value - 1).abs(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                              colors: const [
                                Colors.blue,
                                Colors.green,
                                Colors.yellow,
                                Colors.red,
                              ],
                              stops: const [0.0, 0.25, 0.5, 1.0],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              transform: GradientRotation(_loadingAnimation.value * pi),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            // Close and open programatically - https://stackoverflow.com/a/73005357
            child: OpenContainer(
              routeSettings: RouteSettings(name: widget.menuItem.id),
              closedColor: context.theme.colorScheme.surfaceContainer,
              closedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              openColor: context.theme.colorScheme.surfaceContainer,
              tappable: false,
              closedBuilder: (context, closedBuilder) {
                return MenuItemClosedCard(
                  menuItem: widget.menuItem,
                  animatedSizeDuration: _animatedSizeDuration,
                  onOpen: closedBuilder,
                );
              },
              openBuilder: (context, openBuilder) {
                return MenuItemDetailsPage(
                  menuItem: widget.menuItem,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItemClosedCard extends ConsumerWidget {
  const MenuItemClosedCard({
    required this.menuItem,
    required this.animatedSizeDuration,
    required this.onOpen,
    super.key,
  });

  final MenuItem menuItem;
  final Duration animatedSizeDuration;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedSize(
      duration: animatedSizeDuration,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              menuItem.title,
              style: context.theme.textTheme.titleLarge?.copyWith(
                color: context.theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            if (menuItem.subtitle != null)
              Text(
                menuItem.subtitle!,
                style: context.theme.textTheme.titleSmall?.copyWith(
                  color: context.theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            if (menuItem is ProcessedMenuItem) ...[
              SizedBox(height: context.theme.appSpacing.small),
              Text(
                (menuItem as ProcessedMenuItem).description,
                style: context.theme.textTheme.bodySmall?.copyWith(
                  color: context.theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.theme.appSpacing.small),
              if ((menuItem as ProcessedMenuItem).isVegetarian || (menuItem as ProcessedMenuItem).isVegan)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/vegetarian.svg',
                      height: 24 *
                          MediaQuery.textScalerOf(context).scale(context.theme.textTheme.headlineSmall!.fontSize!) /
                          context.theme.textTheme.headlineSmall!.fontSize!,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      (menuItem as ProcessedMenuItem).isVegetarian ? 'Vegetarian' : 'Vegan',
                      style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurface),
                    ),
                  ],
                ),
              SizedBox(height: context.theme.appSpacing.small),
              const Divider(),
              Text(
                'Potential Allergens',
                style: TextStyle(fontWeight: FontWeight.bold, color: context.theme.colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              MenuItemAllergens(menuItem: menuItem as ProcessedMenuItem),
              TextButton(
                onPressed: onOpen.call,
                child: const Text('Learn more'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
