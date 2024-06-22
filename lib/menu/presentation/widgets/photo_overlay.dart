import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui show Image;

import 'package:flutter/foundation.dart';
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

class _PhotoOverlayState extends ConsumerState<PhotoOverlay> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late List<Offset> _points;
  late List<Tween<Offset>> _tweens;
  late final Timer _timer;
  late final Random _random;

  Photo get photo => widget.photo;

  @override
  void initState() {
    super.initState();
    _random = Random();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    );
    _animationController.forward();
    _timer = Timer.periodic(
      const Duration(milliseconds: 3000),
      (_) {
        _tweens = _generateTweens();
        _animationController
          ..reset()
          ..forward();
      },
    );
    _points = _generateInitialRandomPoints();
    _tweens = _generateTweens();
  }

  /// Generate a list of tweens to animate the points.
  List<Tween<Offset>> _generateTweens() {
    final tweens = <Tween<Offset>>[];
    for (var i = 0; i < _points.length; i++) {
      final startPoint = _points[i];
      final nextPoint = _generateNextPoint(startPoint);
      tweens.add(Tween(begin: startPoint, end: nextPoint));
      _points[i] = nextPoint;
    }
    return tweens;
  }

  Offset _generateNextPoint(Offset currentPoint) {
    late final int xSign;
    if (currentPoint.dx == 0) {
      xSign = 1;
    } else if (currentPoint.dx == 1) {
      xSign = -1;
    } else {
      xSign = _random.nextBool() ? 1 : -1;
    }
    late final int ySign;
    if (currentPoint.dy == 0) {
      ySign = 1;
    } else if (currentPoint.dy == 1) {
      ySign = -1;
    } else {
      ySign = _random.nextBool() ? 1 : -1;
    }
    final nextPoint = Offset(
      clampDouble(currentPoint.dx + _random.nextDouble() * 0.2 * xSign, 0, 1),
      clampDouble(currentPoint.dy + _random.nextDouble() * 0.2 * ySign, 0, 1),
    );
    return nextPoint;
  }

  /// Generate a list of random points within a unit square.
  List<Offset> _generateInitialRandomPoints() {
    final generatedPoints = <Offset>[];
    const numberOfPoints = 40;

    // Generate points within a unit square (0,0) to (1,1)
    for (var i = 0; i < numberOfPoints; i++) {
      final x = _random.nextDouble();
      final y = _random.nextDouble();
      generatedPoints.add(Offset(x, y));
    }

    return generatedPoints;
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      photoAnalyserControllerProvider(widget.photo),
      (prev, state) {
        state.whenOrNull(
          data: (data) {
            ref.read(currentMenuItemsProvider.notifier).addNewMenuItems(data);
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

    return ColoredBox(
      color: Colors.black.withOpacity(0.8),
      child: Padding(
        padding: EdgeInsets.all(context.theme.appSpacing.large),
        child: Stack(
          children: [
            FutureBuilder<ui.Image>(
              future: decodeImageFromList(photo.photoData),
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: !snapshot.hasData
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: ImageProcessingPainter(
                                snapshot.data!,
                                _animation.value,
                                _tweens.map((tween) => tween.evaluate(_animation)).toList(),
                              ),
                              child: const SizedBox.expand(),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageProcessingPainter extends CustomPainter {
  ImageProcessingPainter(
    this.image,
    this.animationValue,
    this.points,
  );

  final ui.Image image;
  final double animationValue;
  final List<Offset> points;

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate the scale to fit the image within the available space
    final imageWidth = image.width.toDouble();
    final imageHeight = image.height.toDouble();
    final canvasWidth = size.width;
    final canvasHeight = size.height;

    final scale = (canvasWidth / imageWidth).clamp(0, 1);
    final scaledWidth = imageWidth * scale;
    final scaledHeight = imageHeight * scale;

    // Calculate the offset to center the image
    final offsetX = (canvasWidth - scaledWidth) / 2;
    final offsetY = (canvasHeight - scaledHeight) / 2;

    final dstRect = Rect.fromLTWH(offsetX, offsetY, scaledWidth, scaledHeight);

    // Draw the image on the canvas
    paintImage(
      canvas: canvas,
      rect: dstRect,
      image: image,
      fit: BoxFit.contain,
    );

    // Draw a rectangle around the edge of the canvas
    final Paint rectPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), rectPaint);
    canvas.drawRect(dstRect, rectPaint..color = Colors.green);

    final Paint pointPaint = Paint()..color = Colors.blue;

    // Adjust the points to fit within the scaled image bounds
    for (final point in points) {
      final adjustedX = point.dx * scaledWidth + offsetX;
      final adjustedY = point.dy * scaledHeight + offsetY;
      canvas.drawCircle(Offset(adjustedX, adjustedY), 4, pointPaint);
    }
  }

  @override
  bool shouldRepaint(covariant ImageProcessingPainter oldDelegate) {
    return true;
  }
}
