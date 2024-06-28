import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/common/widgets/multi_colored_progress_indicator.dart';

class ProcessingLoadingOverlay extends ConsumerStatefulWidget {
  const ProcessingLoadingOverlay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProcessingLoadingOverlayState();
}

class _ProcessingLoadingOverlayState extends ConsumerState<ProcessingLoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Material(
        type: MaterialType.card,
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MultiColoredProgressIndicator.circular(),
              SizedBox(width: 10),
              Text('Processing...'),
            ],
          ),
        ),
      ),
    );
  }
}
