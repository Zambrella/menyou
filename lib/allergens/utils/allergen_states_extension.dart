import 'package:flutter/material.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';

extension AllergenStatesX on AllergenStates {
  String prettyPrint(BuildContext context) {
    return switch (this) {
      AllergenStates.tolerant => 'Fine',
      AllergenStates.intolerant => 'Intolerant',
      AllergenStates.allergic => 'Allergic',
    };
  }
}
