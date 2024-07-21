import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:men_you/theme/theme_extensions.dart';
import 'package:toastification/toastification.dart';

extension ToastificationX on Toastification {
  ToastificationItem showSuccess({required BuildContext context, required String message}) {
    return show(
      context: context,
      title: Text(message),
      type: ToastificationType.success,
      style: ToastificationStyle.flatColored,
      primaryColor: Colors.green.harmonizeWith(context.theme.colorScheme.primary),
      backgroundColor: HSLColor.fromColor(Colors.green).withLightness(0.9).toColor().harmonizeWith(context.theme.colorScheme.primary),
      foregroundColor: context.theme.colorScheme.onSurface,
      autoCloseDuration: const Duration(seconds: 5),
      borderRadius: BorderRadius.circular(10),
      closeOnClick: true,
      pauseOnHover: true,
      dismissDirection: DismissDirection.vertical,
    );
  }

  ToastificationItem showError({required BuildContext context, required String message}) {
    return show(
      context: context,
      title: Text(message),
      type: ToastificationType.error,
      style: ToastificationStyle.flatColored,
      primaryColor: Colors.red.harmonizeWith(context.theme.colorScheme.primary),
      backgroundColor: HSLColor.fromColor(Colors.red).withLightness(0.9).toColor().harmonizeWith(context.theme.colorScheme.primary),
      foregroundColor: context.theme.colorScheme.onSurface,
      borderRadius: BorderRadius.circular(10),
      closeOnClick: true,
      pauseOnHover: true,
      dismissDirection: DismissDirection.vertical,
      showProgressBar: false,
    );
  }
}
