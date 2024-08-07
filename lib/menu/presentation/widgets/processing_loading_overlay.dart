import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/common/widgets/multi_colored_progress_indicator.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';

class ProcessingLoadingOverlay extends ConsumerStatefulWidget {
  const ProcessingLoadingOverlay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProcessingLoadingOverlayState();
}

class _ProcessingLoadingOverlayState extends ConsumerState<ProcessingLoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Center(
      child: Material(
        type: MaterialType.card,
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MultiColoredProgressIndicator.circular(),
              const SizedBox(width: 10),
              Text('${l10n.processing}...'),
            ],
          ),
        ),
      ),
    );
  }
}
