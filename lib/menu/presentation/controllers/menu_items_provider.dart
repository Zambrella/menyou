import 'package:collection/collection.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_processing_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_items_provider.g.dart';

@riverpod
class CurrentMenuItems extends _$CurrentMenuItems {
  @override
  List<MenuItem> build() {
    return [];
  }

  /// Add new [MenuItem]s to the current list of [MenuItem]s.
  /// These new [MenuItem]s are sent for processing by the [MenuItemsProcessingController].
  void addNewMenuItems(List<MenuItem> menuItems) {
    // Only add items that are not already in the list.
    // Comparing by id instead of the object itself so that we can replace unprocessed items with processed ones.
    final toAdd = menuItems.where((item) => state.none((menuItem) => menuItem.id == item.id)).toList();
    state = List<MenuItem>.from([...state, ...toAdd]);

    // Only process the items that are not already processed.
    final notProcessed = toAdd.whereType<UnprocessedMenuItem>().toList();
    ref.read(menuItemsProcessingControllerProvider.notifier).processMenuItems(notProcessed);
  }

  /// Add processed menu items to the current list of menu items.
  /// Any unprocessed items are replaced with the new processed items.
  void addProcessedMenuItems(List<MenuItem> menuItems) {
    final newList = state.map((item) {
      final processed = menuItems.firstWhereOrNull((menuItem) => menuItem.id == item.id);
      if (processed != null) {
        return processed;
      }
      return item;
    }).toList();
    state = newList;
  }
}
