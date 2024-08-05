import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_processing_controller.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/presentation/widgets/menu_item_card.dart';
import 'package:men_you/menu/presentation/widgets/photo_overlay.dart';
import 'package:men_you/menu/presentation/widgets/processing_loading_overlay.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:men_you/photos/presentation/controllers/get_photo_controller.dart';
import 'package:men_you/theme/theme_extensions.dart';

class MenuList extends ConsumerStatefulWidget {
  const MenuList({
    super.key,
    this.menuItems,
  });

  final List<MenuItem>? menuItems;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuListState();
}

class _MenuListState extends ConsumerState<MenuList> with TickerProviderStateMixin {
  OverlayEntry? _photoOverlayEntry;
  OverlayEntry? _loadingOverlayEntry;

  late final AnimationController _photoOverlayAnimationController;
  late final Animation<double> _photoOverlayAnimation;
  late final AnimationController _loadingOverlayAnimationController;
  late final Animation<double> _loadingOverlayPositionAnimation;
  late final Animation<double> _loadingOverlayOpacityAnimation;

  static const _loadingOverlayHeight = 75.0;

  @override
  void initState() {
    super.initState();
    _photoOverlayAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _photoOverlayAnimation = CurvedAnimation(
      parent: _photoOverlayAnimationController,
      curve: Curves.easeInOut,
    );
    _loadingOverlayAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _loadingOverlayPositionAnimation = Tween<double>(begin: -_loadingOverlayHeight - 10, end: 0).animate(
      CurvedAnimation(
        parent: _loadingOverlayAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
    _loadingOverlayOpacityAnimation = CurvedAnimation(
      parent: _loadingOverlayAnimationController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.menuItems != null) {
        ref.read(currentMenuItemsProvider.notifier).addNewMenuItems(widget.menuItems!);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> removePhotoOverlay() async {
    await _photoOverlayAnimationController.reverse();
    _photoOverlayEntry?.remove();
    _photoOverlayEntry?.dispose();
    _photoOverlayEntry = null;
  }

  Future<void> removeLoadingOverlay() async {
    await _loadingOverlayAnimationController.reverse();
    _loadingOverlayEntry?.remove();
    _loadingOverlayEntry?.dispose();
    _loadingOverlayEntry = null;
  }

  void showPhoto(Photo photo) {
    _photoOverlayAnimationController.forward(from: 0);
    _photoOverlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: AnimatedBuilder(
            animation: _photoOverlayAnimationController,
            builder: (context, _) {
              return Opacity(
                opacity: _photoOverlayAnimation.value,
                child: PhotoOverlay(
                  photo: photo,
                  onDismiss: removePhotoOverlay,
                ),
              );
            },
          ),
        );
      },
    );
    Overlay.of(context, debugRequiredFor: widget).insert(_photoOverlayEntry!);
  }

  void showLoadingOverlay() {
    _loadingOverlayAnimationController.forward(from: 0);
    _loadingOverlayEntry = OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          animation: _loadingOverlayAnimationController,
          builder: (context, _) {
            return Positioned(
              bottom: _loadingOverlayPositionAnimation.value + _loadingOverlayHeight,
              left: 0,
              right: 0,
              child: Opacity(
                opacity: _loadingOverlayOpacityAnimation.value,
                child: const ProcessingLoadingOverlay(),
              ),
            );
          },
        );
      },
    );
    Overlay.of(context, debugRequiredFor: widget).insert(_loadingOverlayEntry!);
  }

  @override
  void dispose() {
    _photoOverlayEntry?.remove();
    _photoOverlayEntry?.dispose();
    _loadingOverlayEntry?.remove();
    _loadingOverlayEntry?.dispose();
    _photoOverlayAnimationController.dispose();
    _loadingOverlayAnimationController.dispose();
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

    // ignore: cascade_invocations
    ref.listen(menuItemsProcessingControllerProvider, (prev, state) {
      switch (state) {
        case MenuItemProcessingInProgress():
          if (prev is! MenuItemProcessingInProgress) {
            showLoadingOverlay();
          }
        case _:
          removeLoadingOverlay();
      }
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final menuItem in ref.watch(currentMenuItemsProvider))
            MenuItemCard(
              key: ValueKey(menuItem.id),
              menuItem: menuItem,
            ),
          SizedBox(height: context.theme.appSpacing.small),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.theme.appSpacing.small),
            child: OutlinedButton.icon(
              onPressed: ref.watch(getPhotoControllerProvider).isLoading
                  ? null
                  : () {
                      ref.read(getPhotoControllerProvider.notifier).getPhoto(ImageSource.camera);
                    },
              icon: SvgPicture.asset(
                context.theme.brightness == Brightness.light ? 'assets/icons/photo-camera.svg' : 'assets/icons/photo-camera-outlined.svg',
                width: context.theme.textTheme.titleLarge!.fontSize,
                height: context.theme.textTheme.titleLarge!.fontSize,
                colorFilter: ColorFilter.mode(
                  context.theme.colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: const Text('Take Photo'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.theme.appSpacing.small),
            child: OutlinedButton.icon(
              onPressed: ref.watch(getPhotoControllerProvider).isLoading
                  ? null
                  : () {
                      ref.read(getPhotoControllerProvider.notifier).getPhoto(ImageSource.gallery);
                    },
              icon: SvgPicture.asset(
                context.theme.brightness == Brightness.light ? 'assets/icons/image.svg' : 'assets/icons/image-outlined.svg',
                width: context.theme.textTheme.titleLarge!.fontSize,
                height: context.theme.textTheme.titleLarge!.fontSize,
                colorFilter: ColorFilter.mode(
                  context.theme.colorScheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              label: const Text('Select Photo'),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
