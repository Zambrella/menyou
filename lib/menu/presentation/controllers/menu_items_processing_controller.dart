import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/repository/menu_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_items_processing_controller.g.dart';

sealed class MenuItemProcessingState {
  const MenuItemProcessingState();
}

class MenuItemProcessingIdle extends MenuItemProcessingState {
  const MenuItemProcessingIdle();
}

class MenuItemProcessingInProgress extends MenuItemProcessingState {
  const MenuItemProcessingInProgress(this.menuItems);

  final List<MenuItem> menuItems;
}

class MenuItemProcessingError extends MenuItemProcessingState {
  const MenuItemProcessingError(this.error);

  final Object error;
}

/// A controller that processes menu items.
/// The state holds a list of menu items that are being processed.
@riverpod
class MenuItemsProcessingController extends _$MenuItemsProcessingController {
  @override
  MenuItemProcessingState build() {
    return const MenuItemProcessingIdle();
  }

  /// Given a list of menu items, process them.
  Future<void> processMenuItems(List<MenuItem> menuItems) async {
    state = MenuItemProcessingInProgress(menuItems);

    final futures = menuItems.map(ref.read(menuRepositoryProvider).processMenuItem);

    Stream.fromFutures(futures).listen(
      (menuItem) {
        ref.read(currentMenuItemsProvider.notifier).addProcessedMenuItems([menuItem]);
        switch (state) {
          case MenuItemProcessingInProgress(:final menuItems):
            final newList = menuItems..remove(menuItem);
            state = MenuItemProcessingInProgress(newList);
          case _:
          // Do nothing
        }
      },
      onError: (Object e, _) {
        state = MenuItemProcessingError(e);
      },
      onDone: () {
        state = const MenuItemProcessingIdle();
      },
    );
  }
}
