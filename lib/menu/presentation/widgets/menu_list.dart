import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/presentation/widgets/menu_item_card.dart';
import 'package:men_you/menu/presentation/widgets/photo_overlay.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:men_you/photos/presentation/controllers/get_photo_controller.dart';

class MenuList extends ConsumerStatefulWidget {
  const MenuList({
    super.key,
    this.menuItems,
  });

  final List<MenuItem>? menuItems;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuListState();
}

class _MenuListState extends ConsumerState<MenuList> {
  OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.menuItems != null) {
        ref.read(currentMenuItemsProvider.notifier).addNewMenuItems(widget.menuItems!);
      }
    });
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;
  }

  void showPhoto(Photo photo) {
    overlayEntry = OverlayEntry(
      builder: (context) {
        // TODO: Animate entry and exit of overlay
        return Positioned.fill(
          child: ColoredBox(
            color: Colors.black.withOpacity(0.5),
            child: PhotoOverlay(
              photo: photo,
              onDismiss: removeOverlay,
            ),
          ),
        );
      },
    );
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getPhotoControllerProvider, (prev, state) {
      state.whenOrNull(
        data: (data) {
          if (data != null) {
            showPhoto(data);
          }
        },
      );
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          for (final menuItem in ref.watch(currentMenuItemsProvider))
            MenuItemCard(
              key: ValueKey(menuItem.id),
              menuItem: menuItem,
            ),
          ElevatedButton(
            onPressed: ref.watch(getPhotoControllerProvider).isLoading
                ? null
                : () {
                    ref.read(getPhotoControllerProvider.notifier).getPhoto(ImageSource.camera);
                  },
            child: const Text('Take Photo'),
          ),
          ElevatedButton(
            onPressed: ref.watch(getPhotoControllerProvider).isLoading
                ? null
                : () {
                    ref.read(getPhotoControllerProvider.notifier).getPhoto(ImageSource.gallery);
                  },
            child: const Text('Select Photo'),
          ),
        ],
      ),
    );
  }
}
