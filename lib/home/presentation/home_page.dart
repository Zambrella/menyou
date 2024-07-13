import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/routing/app_router.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menus'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('List of previous menus...'),
          ],
        ),
      ),
    );
  }
}
