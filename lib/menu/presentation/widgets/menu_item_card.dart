import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/menu/domain/menu_item.dart';

class MenuItemCard extends ConsumerStatefulWidget {
  const MenuItemCard({
    required this.menuItem,
    super.key,
  });

  final MenuItem menuItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuItemCardState();
}

class _MenuItemCardState extends ConsumerState<MenuItemCard> with SingleTickerProviderStateMixin {
  late final AnimationController _loadingAnimationController;
  late final Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    _loadingAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    );
    _loadingAnimation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _loadingAnimationController,
        curve: Curves.linear,
      ),
    );
    _loadingAnimationController.repeat();
  }

  @override
  void didUpdateWidget(covariant MenuItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.menuItem is ProcessedMenuItem && oldWidget.menuItem is UnprocessedMenuItem) {
      _loadingAnimationController.stop();
      // Stop the loading animation
      // Transform into a different style of card? (this could be handled implicitly by the widget itself though)
    }
  }

  @override
  void dispose() {
    _loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: AnimatedBuilder(
              animation: _loadingAnimation,
              builder: (context, _) {
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: widget.menuItem is UnprocessedMenuItem ? 1 : 0,
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
        Card(
          // color: Colors.transparent,
          margin: const EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(widget.menuItem.title),
                Text(widget.menuItem.description),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
