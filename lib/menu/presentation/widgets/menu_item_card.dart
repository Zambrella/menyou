import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/menu/domain/menu_item.dart';
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
    _loadingAnimationController.repeat();
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
    return Stack(
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
        AnimatedSize(
          duration: _animatedSizeDuration,
          child: Card(
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.menuItem.title,
                    style: context.theme.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  if (widget.menuItem.subtitle != null)
                    Text(
                      widget.menuItem.subtitle!,
                      style: context.theme.textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  if (widget.menuItem is ProcessedMenuItem) ...[
                    SizedBox(height: context.theme.appSpacing.small),
                    Text(
                      (widget.menuItem as ProcessedMenuItem).description,
                      style: context.theme.textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: context.theme.appSpacing.small),
                    const Divider(),
                    const Text(
                      'Allergens',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Wrap(
                      spacing: context.theme.appSpacing.small,
                      // runSpacing: context.theme.appSpacing.small,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final allergen in (widget.menuItem as ProcessedMenuItem).allergens)
                          Chip(
                            label: Text(
                              allergen,
                              style: context.theme.textTheme.bodySmall,
                            ),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
