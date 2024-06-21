import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_processing_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_items_provider.g.dart';

@riverpod
class CurrentMenuItems extends _$CurrentMenuItems {
  @override
  List<MenuItem>? build() {
    return null;
  }

  /// Add new menu items to the current list of menu items.
  /// These new items are sent for processing by the [MenuItemsProcessingController].
  void addNewMenuItems(List<MenuItem> menuItems) {
    // TODO: Check if the items are already processed
    state = List<MenuItem>.from([...?state, ...menuItems]);
    ref.read(menuItemsProcessingControllerProvider.notifier).processMenuItems(menuItems);
  }

  /// Add processed menu items to the current list of menu items.
  /// Any unprocessed items are replaced with the new processed items.
  void addProcessedMenuItems(List<MenuItem> menuItems) {
    // TODO: Swap out the old items with the new ones
    state = List<MenuItem>.from([...state!, ...menuItems]);
  }
}
