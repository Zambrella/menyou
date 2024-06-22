import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProcessingLoadingOverlay extends ConsumerStatefulWidget {
  const ProcessingLoadingOverlay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProcessingLoadingOverlayState();
}

class _ProcessingLoadingOverlayState extends ConsumerState<ProcessingLoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.card,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text('Processing...'),
            ],
          ),
        ),
      ),
    );
  }
}
