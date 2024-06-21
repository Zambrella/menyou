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

class _MenuItemCardState extends ConsumerState<MenuItemCard> {
  @override
  void initState() {
    super.initState();
    if (widget.menuItem is UnprocessedMenuItem) {
      // Start the loading animation
    }
  }

  @override
  void didUpdateWidget(covariant MenuItemCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.menuItem is ProcessedMenuItem && oldWidget.menuItem is UnprocessedMenuItem) {
      // Stop the loading animation
      // Transform into a different style of card? (this could be handled implicitly by the widget itself though)
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.menuItem.title),
      subtitle: Text(widget.menuItem.description),
      trailing: widget.menuItem.when(
        unprocessed: (_, __, ___) => const CircularProgressIndicator(),
        processed: (_, __, ___) => null,
      ),
    );
  }
}
