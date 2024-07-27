import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/photos/domain/photo.dart';

abstract class MenuRepository {
  Future<List<RestaurantMenu>> getAllMenus();
  Future<RestaurantMenu> getMenuById(String id);
  Future<void> addMenu(RestaurantMenu menu);
  Future<void> updateMenu(RestaurantMenu menu);
  Future<void> deleteMenu(String menuId);
  Future<List<MenuItem>> analysePhoto(Photo photo);
  Future<MenuItem> processMenuItem(MenuItem menuItem);
  Future<String> generateImage(ProcessedMenuItem menuItem);
  Future<String> sendMessageAboutMenuItem(ProcessedMenuItem menuItem, String message);
}
