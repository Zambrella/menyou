import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';
import 'package:men_you/theme/theme_extensions.dart';

class ConsentDialog extends ConsumerStatefulWidget {
  const ConsentDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ConsentDialogState();
}

class _ConsentDialogState extends ConsumerState<ConsentDialog> {
  bool consentStatus = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      backgroundColor: context.theme.colorScheme.surface,
      title: Text(
        l10n.aiWarningTitle,
        style: TextStyle(color: Colors.orange.harmonizeWith(context.theme.colorScheme.error)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.aiWarningMessage,
            style: context.theme.textTheme.bodyLarge?.copyWith(
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              l10n.aiWarningDontShowAgain,
              style: context.theme.textTheme.bodyLarge?.copyWith(
                color: context.theme.colorScheme.onSurface,
              ),
            ),
            value: consentStatus,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  consentStatus = value;
                });
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(consentStatus);
          },
          child: Text(l10n.aiWarningCTA),
        ),
      ],
    );
  }
}
