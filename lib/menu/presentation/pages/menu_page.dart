import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/presentation/controllers/menu_page_controller.dart';
import 'package:men_you/menu/presentation/controllers/save_menu_controller.dart';
import 'package:men_you/menu/presentation/widgets/menu_list.dart';
import 'package:men_you/photos/presentation/controllers/get_photo_controller.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenuPage extends ConsumerStatefulWidget {
  const MenuPage({
    required this.menuId,
    this.restaurantMenu,
    super.key,
  });

  final String menuId;
  final RestaurantMenu? restaurantMenu;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuPageState();
}

class _MenuPageState extends ConsumerState<MenuPage> {
  late ColorScheme colorScheme;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    colorScheme = context.theme.colorScheme;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getPhotoControllerProvider, (prev, state) {
      state.whenOrNull(
        data: (data) async {
          if (data != null) {
            final pictureColorScheme = await ColorScheme.fromImageProvider(
              provider: Image.memory(data.photoData).image,
              brightness: context.theme.brightness,
            );
            setState(() {
              colorScheme = pictureColorScheme;
            });
          }
        },
      );
    });

    // TODO: Listen to menu list controller and update the menu page controller with new menu.
    // ignore: cascade_invocations
    ref.listen(currentMenuItemsProvider, (prev, state) {
      ref.read(menuPageControllerProvider(widget.menuId, widget.restaurantMenu).notifier).updateMenu(
            ref.read(menuPageControllerProvider(widget.menuId, widget.restaurantMenu)).requireValue.copyWith(menuItems: state),
          );
    });

    // ignore: cascade_invocations
    ref.listen(saveMenuControllerProvider, (prev, state) {
      if (state is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving menu: ${state.error}'),
          ),
        );
      } else if (state is AsyncData) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Menu saved successfully'),
          ),
        );
      }
    });

    final menuController = ref.watch(menuPageControllerProvider(widget.menuId, widget.restaurantMenu));

    return PopScope(
      onPopInvoked: (_) {
        // TODO: If the menu is not saved, ask the user if they want to save it.
      },
      child: Theme(
        data: context.theme.copyWith(colorScheme: colorScheme),
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.restaurantMenu?.name ?? 'New Menu'),
            actions: [
              IconButton(
                onPressed: menuController.hasValue
                    ? () async {
                        await ref.read(saveMenuControllerProvider.notifier).saveMenu(
                              menuController.requireValue,
                            );
                      }
                    : null,
                icon: ref.watch(saveMenuControllerProvider).isLoading ? const CircularProgressIndicator() : const Icon(Icons.save),
              ),
            ],
          ),
          body: menuController.when(
            data: (menu) {
              return MenuList(
                menuItems: menu.menuItems,
              );
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
            error: (e, _) => Center(
              child: Text('Error: $e'),
            ),
          ),
        ),
      ),
    );
  }
}
