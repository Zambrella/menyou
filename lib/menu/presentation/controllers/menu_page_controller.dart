import 'dart:async';

import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_page_controller.g.dart';

@riverpod
class MenuPageController extends _$MenuPageController {
  @override
  FutureOr<RestaurantMenu> build(String menuId, RestaurantMenu? restaurantMenu) async {
    if (restaurantMenu == null) {
      return await loadMenu(menuId);
    } else {
      return restaurantMenu;
    }
  }

  /// This method loads a menu from the repository.
  /// Only needed to be called if the user navigates to the menu page directly.
  Future<RestaurantMenu> loadMenu(String menuId) async {
    try {
      // TODO: Fetch from menu repository
      final restaurantMenu = RestaurantMenu.empty();
      return Future.value(restaurantMenu);
    } catch (e, st) {
      return Future.error(e, st);
    }
  }

  // TODO: Put this in it's own controller
  Future<void> saveMenu(RestaurantMenu restaurantMenu) async {
    // TODO: Save to menu repository
  }
}
