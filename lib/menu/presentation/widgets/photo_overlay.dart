import 'dart:async';
import 'dart:math';
import 'dart:ui' as ui show Image;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/common/extensions/toastification_extensions.dart';
import 'package:men_you/common/widgets/multi_colored_progress_indicator.dart';
import 'package:men_you/menu/presentation/controllers/menu_items_provider.dart';
import 'package:men_you/menu/presentation/controllers/photo_analyser_controller.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:men_you/theme/theme_extensions.dart';
import 'package:toastification/toastification.dart';

/// key: index of the point, value: list of indices of points to connect to.
typedef PointPairings = Map<int, List<int>>;

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

class _PhotoOverlayState extends ConsumerState<PhotoOverlay> with TickerProviderStateMixin {
  //* Constants
  static const _numberOfPoints = 25;
  static const _numberOfPairings = 2;
  static const _pointDuration = Duration(milliseconds: 2500);
  static const _brightnessDuration = Duration(milliseconds: 1000);
  static const _flashDuration = Duration(milliseconds: 1000);
  static const _unblurDuration = Duration(milliseconds: 10000);
  static const _movementFactor = 0.20;
  static const _potentialColors = [Colors.blue, Colors.green, Colors.yellow, Colors.red];

  //* Variables
  late final AnimationController _pointAnimationController;
  late final AnimationController _brightnessAnimationController;
  late final AnimationController _unblurController;
  late final Animation<double> _pointAnimation;
  late final Animation<double> _brightnessAnimation;
  late final Animation<double> _unblurAnimation;
  late List<Offset> _points;
  late List<Tween<Offset>> _offsetTweens;
  late List<int> _flashingPoints;
  late final Timer _pointsTimer;
  late final Timer _flashTimer;
  late final Random _random;
  late final PointPairings _pairings;
  late final List<Color> _pointColors;

  Photo get photo => widget.photo;

  @override
  void initState() {
    super.initState();
    _random = Random();
    _pointAnimationController = AnimationController(
      vsync: this,
      duration: _pointDuration,
    );
    _brightnessAnimationController = AnimationController(
      vsync: this,
      duration: _brightnessDuration,
    );
    _unblurController = AnimationController(
      vsync: this,
      duration: _unblurDuration,
    );

    _pointAnimation = CurvedAnimation(
      parent: _pointAnimationController,
      curve: Curves.easeOutBack,
    );
    _brightnessAnimation = CurvedAnimation(
      parent: _brightnessAnimationController,
      curve: Curves.easeInOut,
    );
    _unblurAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _unblurController,
        curve: Curves.linear,
      ),
    );
    _pointAnimationController.forward();
    _brightnessAnimationController.repeat(reverse: true);
    _pointsTimer = Timer.periodic(
      _pointDuration,
      (_) {
        _offsetTweens = _generateTweens();
        _pointAnimationController
          ..reset()
          ..forward();
      },
    );
    _flashTimer = Timer.periodic(
      // Flash duration is just for the forward part of the animation so we need to double it.
      _flashDuration * 2,
      (_) {
        _flashingPoints = _generateFlashingPoints();
      },
    );
    _points = _generateInitialRandomPoints();
    _offsetTweens = _generateTweens();
    _pairings = _generatePairings();
    _flashingPoints = _generateFlashingPoints();
    _unblurController.forward();
    _pointColors = List<Color>.generate(
      _numberOfPoints,
      (i) => _potentialColors[i % _potentialColors.length],
      growable: false,
    );
  }

  List<int> _generateFlashingPoints() {
    return List<int>.generate(
      3,
      (_) => _random.nextInt(_numberOfPoints),
      growable: false,
    );
  }

  PointPairings _generatePairings() {
    final pairings = <int, List<int>>{};

    for (var i = 0; i < _numberOfPoints; i++) {
      pairings[i] = [
        for (var j = 0; j < _numberOfPairings; j++) _random.nextInt(_numberOfPoints),
      ];
    }

    return pairings;
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
      clampDouble(currentPoint.dx + _random.nextDouble() * _movementFactor * xSign, 0, 1),
      clampDouble(currentPoint.dy + _random.nextDouble() * _movementFactor * ySign, 0, 1),
    );
    return nextPoint;
  }

  /// Generate a list of random points within a unit square.
  List<Offset> _generateInitialRandomPoints() {
    final generatedPoints = <Offset>[];

    // Generate points within a unit square (0,0) to (1,1)
    for (var i = 0; i < _numberOfPoints; i++) {
      final x = _random.nextDouble();
      final y = _random.nextDouble();
      generatedPoints.add(Offset(x, y));
    }

    return generatedPoints;
  }

  @override
  void dispose() {
    _pointsTimer.cancel();
    _flashTimer.cancel();
    _pointAnimationController.dispose();
    _brightnessAnimationController.dispose();
    _unblurController.dispose();
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
            toastification.showError(context: context, message: 'Error: $e');
            widget.onDismiss();
          },
        );
      },
    );

    return ColoredBox(
      color: Colors.black.withOpacity(0.8),
      child: Padding(
        // padding: EdgeInsets.all(context.theme.appSpacing.large),
        padding: EdgeInsets.zero,
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
                          animation: _pointAnimationController,
                          builder: (context, _) {
                            return CustomPaint(
                              painter: ImageProcessingPainter(
                                image: snapshot.data!,
                                points: _offsetTweens.map((tween) => tween.evaluate(_pointAnimation)).toList(),
                                pairings: _pairings,
                                brightnessValue: _brightnessAnimation.value,
                                idxsToFlash: _flashingPoints,
                                blurValue: _unblurAnimation.value,
                                pointColors: _pointColors,
                              ),
                              child: const SizedBox.expand(),
                            );
                          },
                        ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: context.theme.appSpacing.large + MediaQuery.of(context).padding.bottom),
                child: Material(
                  type: MaterialType.transparency,
                  child: Text(
                    'Analysing menu...',
                    style: context.theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(context.theme.appSpacing.small + MediaQuery.of(context).padding.bottom),
                child: const MultiColoredProgressIndicator.linear(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageProcessingPainter extends CustomPainter {
  ImageProcessingPainter({
    required this.image,
    required this.points,
    required this.pairings,
    required this.brightnessValue,
    required this.idxsToFlash,
    required this.blurValue,
    required this.pointColors,
  });

  final ui.Image image;
  final List<Offset> points;
  final PointPairings pairings;
  final double brightnessValue;
  final List<int> idxsToFlash;
  final double blurValue;
  final List<Color> pointColors;

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

    // Draw the image on the canvas with a blur effect.
    canvas.saveLayer(
      dstRect,
      Paint()..imageFilter = ImageFilter.blur(sigmaX: blurValue * 4, sigmaY: blurValue * 4),
    );
    paintImage(
      canvas: canvas,
      rect: dstRect,
      image: image,
      fit: BoxFit.contain,
    );
    canvas.restore();

    final linePaint = Paint()
      ..color = Colors.white60
      ..strokeWidth = 0.5;

    // Draw the connecting lines
    for (final pairing in pairings.entries) {
      for (final index in pairing.value) {
        final point1 = points[pairing.key];
        final point2 = points[index];
        final adjustedX1 = point1.dx * scaledWidth + offsetX;
        final adjustedY1 = point1.dy * scaledHeight + offsetY;
        final adjustedX2 = point2.dx * scaledWidth + offsetX;
        final adjustedY2 = point2.dy * scaledHeight + offsetY;
        final point1Offset = Offset(adjustedX1, adjustedY1);
        final point2Offset = Offset(adjustedX2, adjustedY2);
        canvas.drawLine(point1Offset, point2Offset, linePaint);
        if (idxsToFlash.contains(pairing.key)) {
          final flashLinePaint = Paint()
            ..color = Colors.white
            ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5)
            ..strokeWidth = 1;
          if (brightnessValue < 0.5) {
            canvas.drawLine(
              point1Offset,
              interpolate(point1Offset, point2Offset, brightnessValue * 2),
              flashLinePaint,
            );
          } else {
            canvas.drawLine(
              interpolate(point1Offset, point2Offset, (brightnessValue - 0.5) * 2),
              point2Offset,
              flashLinePaint,
            );
          }
        }
      }
    }

    // Adjust the points to fit within the scaled image bounds and draw.
    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      final adjustedX = point.dx * scaledWidth + offsetX;
      final adjustedY = point.dy * scaledHeight + offsetY;
      final pointOffset = Offset(adjustedX, adjustedY);

      if (idxsToFlash.contains(i)) {
        final flashPaint = Paint()
          ..color = pointColors[i]
          ..maskFilter = MaskFilter.blur(BlurStyle.solid, brightnessValue * 5 + 5);
        canvas.drawCircle(pointOffset, brightnessValue * 4 + 4, flashPaint);
      } else {
        final pointPaint = Paint()
          ..color = pointColors[i]
          ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 5);
        canvas.drawCircle(pointOffset, 4, pointPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant ImageProcessingPainter oldDelegate) {
    return true;
  }
}

Offset interpolate(Offset start, Offset end, double percentage) {
  assert(percentage >= 0.0 && percentage <= 1, 'Percentage must be between 0 and 1');
  final dx = start.dx + (end.dx - start.dx) * percentage;
  final dy = start.dy + (end.dy - start.dy) * percentage;
  return Offset(dx, dy);
}
