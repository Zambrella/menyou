import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/repository/menu_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_menu_controller.g.dart';

@riverpod
class SaveMenuController extends _$SaveMenuController {
  @override
  FutureOr<void> build() {
    // Do nothing
  }

  Future<void> saveMenu(RestaurantMenu restaurantMenu) async {
    try {
      state = const AsyncLoading();
      await ref.read(menuRepositoryProvider).updateMenu(restaurantMenu);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
