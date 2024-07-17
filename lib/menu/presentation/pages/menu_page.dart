import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/menu/domain/restaurant_menu.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/presentation/controllers/menu_page_controller.dart';
import 'package:men_you/menu/presentation/controllers/save_menu_controller.dart';
import 'package:men_you/menu/presentation/widgets/menu_list.dart';
import 'package:men_you/photos/presentation/controllers/get_photo_controller.dart';
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

    return Theme(
      data: context.theme.copyWith(colorScheme: colorScheme),
      child: Scaffold(
        appBar: AppBar(
          title: TextField(
            textCapitalization: TextCapitalization.words,
            textAlign: TextAlign.center,
            style: TextStyle(color: context.theme.colorScheme.onSurface),
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
                    : const Icon(Icons.save),
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
      ),
    );
  }
}

extension ToastificationX on Toastification {
  ToastificationItem showSuccess({required BuildContext context, required String message}) {
    return show(
      context: context,
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      primaryColor: Colors.green.harmonizeWith(context.theme.colorScheme.primary),
      backgroundColor: HSLColor.fromColor(Colors.green).withLightness(0.9).toColor().harmonizeWith(context.theme.colorScheme.primary),
      foregroundColor: context.theme.colorScheme.onSurface,
      autoCloseDuration: const Duration(seconds: 5),
      borderRadius: BorderRadius.circular(10),
      closeOnClick: true,
      pauseOnHover: true,
      dismissDirection: DismissDirection.vertical,
    );
  }

  ToastificationItem showError({required BuildContext context, required String message}) {
    return show(
      context: context,
      title: Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      primaryColor: Colors.red.harmonizeWith(context.theme.colorScheme.primary),
      backgroundColor: HSLColor.fromColor(Colors.red).withLightness(0.9).toColor().harmonizeWith(context.theme.colorScheme.primary),
      foregroundColor: context.theme.colorScheme.onSurface,
      borderRadius: BorderRadius.circular(10),
      closeOnClick: true,
      pauseOnHover: true,
      dismissDirection: DismissDirection.vertical,
      showProgressBar: false,
    );
  }
}
