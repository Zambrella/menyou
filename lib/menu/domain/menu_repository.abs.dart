import 'package:flutter/foundation.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';

abstract class MenuRepository {
  Future<List<RestaurantMenu>> getAllMenus();
  Future<RestaurantMenu> getMenuById(String id);
  Future<void> addMenu(RestaurantMenu menu);
  Future<void> updateMenu(RestaurantMenu menu);
  Future<void> deleteMenu(RestaurantMenu id);

  Future<List<MenuItem>> analysePhoto(Uint8List photo);
  Future<MenuItem> processMenuItem(MenuItem menuItem);
}
