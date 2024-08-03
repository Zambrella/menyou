import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return AlertDialog(
      backgroundColor: context.theme.colorScheme.surface,
      title: Text(
        'Warning',
        style: TextStyle(color: Colors.orange.harmonizeWith(context.theme.colorScheme.error)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'MenYou uses AI and can sometimes generate incorrect or incomplete information. If you are not sure about the results, please make sure to ask the kitchen.',
            style: context.theme.textTheme.bodyLarge?.copyWith(
              color: context.theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Do not show this message again',
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
          child: const Text('Close'),
        ),
      ],
    );
  }
}
