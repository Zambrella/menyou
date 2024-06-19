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
  Widget build(BuildContext context) {
    return Text(widget.menuItem.toString());
  }
}
