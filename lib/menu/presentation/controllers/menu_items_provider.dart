import 'package:men_you/menu/domain/menu_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_items_provider.g.dart';

@riverpod
class CurrentMenuItems extends _$CurrentMenuItems {
  @override
  List<MenuItem>? build() {
    return null;
  }

  void addMenuItems(List<MenuItem> menuItems) {
    state = List<MenuItem>.from([...?state, ...menuItems]);
  }
}
