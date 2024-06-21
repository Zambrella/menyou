import 'dart:math';
import 'dart:typed_data';

import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/domain/menu_repository.abs.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';

class FakeMenuRepository implements MenuRepository {
  const FakeMenuRepository();

  @override
  Future<void> addMenu(RestaurantMenu menu) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return;
  }

  @override
  Future<List<MenuItem>> analysePhoto(Uint8List photo) async {
    await Future<void>.delayed(const Duration(seconds: 5));
    return const [
      MenuItem.unprocessed(
        id: '1',
        title: 'Spaghetti Carbonara',
        description: 'Spaghetti with bacon, eggs, and cheese',
      ),
      MenuItem.unprocessed(
        id: '2',
        title: 'Spaghetti Bolognese',
        description: 'Spaghetti with meat sauce',
      ),
      MenuItem.unprocessed(
        id: '3',
        title: 'Spaghetti Aglio e Olio',
        description: 'Spaghetti with garlic and olive oil',
      ),
    ];
  }

  @override
  Future<void> deleteMenu(RestaurantMenu id) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return;
  }

  @override
  Future<List<RestaurantMenu>> getAllMenus() async {
    await Future<void>.delayed(const Duration(seconds: 5));
    return const [
      RestaurantMenu(
        id: '1',
        name: 'Fake Menu',
        menuItems: [
          MenuItem.unprocessed(
            id: '1',
            title: 'Spaghetti Carbonara',
            description: 'Spaghetti with bacon, eggs, and cheese',
          ),
          MenuItem.unprocessed(
            id: '2',
            title: 'Spaghetti Bolognese',
            description: 'Spaghetti with meat sauce',
          ),
          MenuItem.unprocessed(
            id: '3',
            title: 'Spaghetti Aglio e Olio',
            description: 'Spaghetti with garlic and olive oil',
          ),
        ],
      ),
    ];
  }

  @override
  Future<RestaurantMenu> getMenuById(String id) async {
    await Future<void>.delayed(const Duration(seconds: 5));
    return const RestaurantMenu(
      id: '1',
      name: 'Fake Menu',
      menuItems: [
        MenuItem.unprocessed(
          id: '1',
          title: 'Spaghetti Carbonara',
          description: 'Spaghetti with bacon, eggs, and cheese',
        ),
        MenuItem.unprocessed(
          id: '2',
          title: 'Spaghetti Bolognese',
          description: 'Spaghetti with meat sauce',
        ),
        MenuItem.unprocessed(
          id: '3',
          title: 'Spaghetti Aglio e Olio',
          description: 'Spaghetti with garlic and olive oil',
        ),
      ],
    );
  }

  @override
  Future<void> updateMenu(RestaurantMenu menu) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return;
  }

  @override
  Future<MenuItem> processMenuItem(MenuItem menuItem) async {
    // Wait for a random amount of time between 2 and 7 seconds
    await Future<void>.delayed(Duration(seconds: Random().nextInt(5) + 2));
    return MenuItem.processed(
      id: menuItem.id,
      title: 'Processed ${menuItem.title}',
      description: menuItem.description,
    );
  }
}
