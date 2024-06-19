import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/controllers/menu_page_controller.dart';
import 'package:men_you/menu/presentation/widgets/menu_list.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({
    required this.menuId,
    this.restaurantMenu,
    super.key,
  });

  final String menuId;
  final RestaurantMenu? restaurantMenu;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.restaurantMenu?.name ?? 'New Menu'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: ref.watch(menuPageControllerProvider(widget.menuId, widget.restaurantMenu)).when(
            data: (menu) {
              return MenuList(
                menuItems: menu.menuItems,
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (e, _) => Center(
              child: Text('Error: $e'),
            ),
          ),
    );
  }
}
