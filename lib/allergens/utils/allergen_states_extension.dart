import 'package:flutter/material.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';

extension AllergenStatesX on AllergenStates {
  String prettyPrint(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (this) {
      AllergenStates.tolerant => l10n.allergenStatusSafe,
      AllergenStates.intolerant => l10n.allergenStatusIntolerant,
      AllergenStates.allergic => l10n.allergenStatusAllergic,
    };
  }
}
