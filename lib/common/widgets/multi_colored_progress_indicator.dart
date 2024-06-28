import 'package:flutter/material.dart';

enum ProgressType {
  linear,
  circular,
}

class MultiColoredProgressIndicator extends StatefulWidget {
  const MultiColoredProgressIndicator.linear({super.key, this.type = ProgressType.linear});
  const MultiColoredProgressIndicator.circular({super.key, this.type = ProgressType.circular});

  final ProgressType type;

  @override
  State<MultiColoredProgressIndicator> createState() => _MultiColoredProgressIndicatorState();
}

class _MultiColoredProgressIndicatorState extends State<MultiColoredProgressIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
    _colorAnimation = _controller.drive(
      TweenSequence<Color?>(
        [
          TweenSequenceItem(
            tween: ColorTween(begin: Colors.red, end: Colors.yellow),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: ColorTween(begin: Colors.yellow, end: Colors.green),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: ColorTween(begin: Colors.green, end: Colors.blue),
            weight: 1,
          ),
          TweenSequenceItem(
            tween: ColorTween(begin: Colors.blue, end: Colors.red),
            weight: 1,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.type) {
      ProgressType.linear => LinearProgressIndicator(
          valueColor: _colorAnimation,
        ),
      ProgressType.circular => CircularProgressIndicator(
          valueColor: _colorAnimation,
        ),
    };
  }
}
