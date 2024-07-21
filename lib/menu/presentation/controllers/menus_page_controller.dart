import 'package:men_you/app_dependencies.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/repository/menu_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menus_page_controller.g.dart';

@Riverpod(keepAlive: true)
class MenusPageController extends _$MenusPageController {
  @override
  FutureOr<List<RestaurantMenu>> build() async {
    final allMenus = await ref.watch(menuRepositoryProvider).getAllMenus();
    allMenus.sort();
    return allMenus;
  }

  Future<void> removeMenu(String menuId) async {
    final oldState = state.requireValue;
    try {
      state = AsyncData(List.from(state.requireValue)..removeWhere((menu) => menu.id == menuId));
      await ref.read(menuRepositoryProvider).deleteMenu(menuId);
    } catch (e, st) {
      state = AsyncError(e, st);
      state = AsyncData(oldState);
      await ref.read(errorLoggingRepositoryProvider).logException(e.toString(), stackTrace: st);
    }
  }
}
