import 'package:flutter/material.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';
import 'package:purchases_core/purchases_core.dart';

/// Extension methods for the [SubscriptionLength] enum.
extension SubscriptionLengthX on SubscriptionLength {
  /// Returns the name of the subscription length.
  String subscriptionLengthName(BuildContext context) {
    final loc = AppLocalizations.of(context);
    switch (this) {
      case SubscriptionLength.oneWeek:
        return loc.subscriptionLengthOneWeek;
      case SubscriptionLength.oneMonth:
        return loc.subscriptionLengthOneMonth;
      case SubscriptionLength.twoMonths:
        return loc.subscriptionLengthTwoMonths;
      case SubscriptionLength.threeMonths:
        return loc.subscriptionLengthThreeMonths;
      case SubscriptionLength.sixMonths:
        return loc.subscriptionLengthSixMonths;
      case SubscriptionLength.oneYear:
        return loc.subscriptionLengthOneYear;
      case SubscriptionLength.lifetime:
        return loc.subscriptionLengthLifetime;
      case SubscriptionLength.unknown:
        return loc.subscriptionLengthUnknown;
    }
  }

  /// Returns the length of the subscription that can be used as a suffix.
  String subscriptionLengthPer(BuildContext context) {
    final loc = AppLocalizations.of(context);
    switch (this) {
      case SubscriptionLength.oneWeek:
        return loc.subscriptionLengthPerOneWeek;
      case SubscriptionLength.oneMonth:
        return loc.subscriptionLengthPerOneMonth;
      case SubscriptionLength.twoMonths:
        return loc.subscriptionLengthPerTwoMonths;
      case SubscriptionLength.threeMonths:
        return loc.subscriptionLengthPerThreeMonths;
      case SubscriptionLength.sixMonths:
        return loc.subscriptionLengthPerSixMonths;
      case SubscriptionLength.oneYear:
        return loc.subscriptionLengthPerSixMonths;
      case SubscriptionLength.lifetime:
        return loc.subscriptionLengthPerLifetime;
      case SubscriptionLength.unknown:
        return loc.subscriptionLengthPerUnknown;
    }
  }
}
