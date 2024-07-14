import 'dart:math';

import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/domain/menu_repository.abs.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/photos/domain/photo.dart';

class FakeMenuRepository implements MenuRepository {
  const FakeMenuRepository();

  @override
  Future<void> addMenu(RestaurantMenu menu) async {
    await Future<void>.delayed(const Duration(seconds: 2));
    return;
  }

  @override
  Future<List<MenuItem>> analysePhoto(Photo photo) async {
    await Future<void>.delayed(const Duration(seconds: 3));
    return const [
      MenuItem.unprocessed(
        id: '1',
        title: 'Spaghetti Carbonara',
        subtitle: 'Spaghetti with bacon, eggs, and cheese',
      ),
      MenuItem.unprocessed(
        id: '2',
        title: 'Spaghetti Bolognese',
        subtitle: 'Spaghetti with meat sauce',
      ),
      MenuItem.unprocessed(
        id: '3',
        title: 'Spaghetti Aglio e Olio',
        subtitle: 'Spaghetti with garlic and olive oil',
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
            subtitle: 'Spaghetti with bacon, eggs, and cheese',
          ),
          MenuItem.unprocessed(
            id: '2',
            title: 'Spaghetti Bolognese',
            subtitle: 'Spaghetti with meat sauce',
          ),
          MenuItem.unprocessed(
            id: '3',
            title: 'Spaghetti Aglio e Olio',
            subtitle: 'Spaghetti with garlic and olive oil',
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
          subtitle: 'Spaghetti with bacon, eggs, and cheese',
        ),
        MenuItem.unprocessed(
          id: '2',
          title: 'Spaghetti Bolognese',
          subtitle: 'Spaghetti with meat sauce',
        ),
        MenuItem.unprocessed(
          id: '3',
          title: 'Spaghetti Aglio e Olio',
          subtitle: 'Spaghetti with garlic and olive oil',
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
    await Future<void>.delayed(Duration(milliseconds: Random().nextInt(5000) + 10000));
    return MenuItem.processed(
      id: menuItem.id,
      title: 'Processed ${menuItem.title}',
      subtitle: menuItem.subtitle,
      description:
          'Spaghetti Carbonara is a classic Italian pasta dish from Rome, renowned for its rich and creamy texture. It traditionally consists of spaghetti tossed with a savory sauce made from beaten eggs, grated Pecorino Romano cheese, crispy guanciale (cured pork cheek), and freshly ground black pepper.',
      allergens: ['Milk', 'Gluten', 'Peanuts', 'Sesame', 'Soya'],
      isVegan: Random().nextBool(),
      isVegetarian: Random().nextBool(),
    );
  }
}
