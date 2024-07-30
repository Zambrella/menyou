import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:men_you/common/extensions/toastification_extensions.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/presentation/controllers/menu_page_controller.dart';
import 'package:men_you/menu/presentation/controllers/save_menu_controller.dart';
import 'package:men_you/menu/presentation/widgets/menu_list.dart';
import 'package:men_you/theme/theme_extensions.dart';
import 'package:toastification/toastification.dart';

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
  late final TextEditingController _menuNameController;

  @override
  void initState() {
    super.initState();
    _menuNameController = TextEditingController(text: widget.restaurantMenu?.name);
  }

  @override
  void dispose() {
    _menuNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: cascade_invocations
    ref.listen(currentMenuItemsProvider, (prev, state) {
      ref.read(menuPageControllerProvider(widget.menuId, widget.restaurantMenu).notifier).updateMenu(
            ref.read(menuPageControllerProvider(widget.menuId, widget.restaurantMenu)).requireValue.copyWith(menuItems: state),
          );
    });

    // ignore: cascade_invocations
    ref.listen(saveMenuControllerProvider, (prev, state) {
      if (state is AsyncError) {
        toastification.showError(
          context: context, // optional if you use ToastificationWrapper
          message: 'Error saving menu: ${state.error}',
        );
      } else if (state is AsyncData && prev is AsyncLoading) {
        toastification.showSuccess(
          context: context, // optional if you use ToastificationWrapper
          message: 'Menu saved successfully',
        );
      }
    });

    final menuController = ref.watch(menuPageControllerProvider(widget.menuId, widget.restaurantMenu));

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          textCapitalization: TextCapitalization.words,
          controller: _menuNameController,
          textAlign: TextAlign.center,
          style: context.theme.textTheme.headlineSmall?.copyWith(color: context.theme.colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: 'Menu Name',
            border: InputBorder.none,
            hintStyle: TextStyle(color: context.theme.colorScheme.onSecondaryContainer.withOpacity(0.5)),
          ),
          onChanged: (value) {
            ref.read(menuPageControllerProvider(widget.menuId, widget.restaurantMenu).notifier).updateMenu(
                  menuController.requireValue.copyWith(name: value),
                );
          },
          onSubmitted: (value) {
            ref.read(menuPageControllerProvider(widget.menuId, widget.restaurantMenu).notifier).updateMenu(
                  menuController.requireValue.copyWith(name: value),
                );
          },
        ),
        actions: [
          IconButton(
            onPressed: menuController.hasValue
                ? () async {
                    await ref.read(saveMenuControllerProvider.notifier).saveMenu(
                          menuController.requireValue,
                        );
                  }
                : null,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: ref.watch(saveMenuControllerProvider).isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(),
                    )
                  : SvgPicture.asset(
                      context.theme.brightness == Brightness.light ? 'assets/icons/save.svg' : 'assets/icons/save-outlined.svg',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        context.theme.colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
            ),
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
    );
  }
}
