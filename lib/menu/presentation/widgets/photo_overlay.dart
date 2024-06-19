import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/presentation/controllers/photo_analyser_controller.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:men_you/theme/theme_extensions.dart';

class PhotoOverlay extends ConsumerStatefulWidget {
  const PhotoOverlay({
    required this.photo,
    required this.onDismiss,
    super.key,
  });

  final Photo photo;
  final VoidCallback onDismiss;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PhotoOverlayState();
}

class _PhotoOverlayState extends ConsumerState<PhotoOverlay> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      photoAnalyserControllerProvider(widget.photo),
      (prev, state) {
        state.whenOrNull(
          data: (data) {
            ref.read(currentMenuItemsProvider.notifier).addMenuItems(data);
            widget.onDismiss();
          },
          error: (e, _) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $e'),
              ),
            );
            widget.onDismiss();
          },
        );
      },
    );
    return Padding(
      padding: EdgeInsets.all(context.theme.appSpacing.large),
      child: Stack(
        children: [
          Center(
            child: Image.memory(
              widget.photo.photoData,
              fit: BoxFit.contain,
            ),
          ),
          if (ref.watch(photoAnalyserControllerProvider(widget.photo)).isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
