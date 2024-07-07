import 'package:men_you/allergens/domain/allergen.dart';

extension AllergenIconX on Allergen {
  String get svgIcon {
    return switch (id) {
      '1' => 'assets/icons/celery.svg',
      '2' => 'assets/icons/gluten.svg',
      '3' => 'assets/icons/crab.svg',
      '4' => 'assets/icons/egg.svg',
      '5' => 'assets/icons/fish.svg',
      '6' => 'assets/icons/lupin.svg',
      '7' => 'assets/icons/milk-bottle.svg',
      '8' => 'assets/icons/mussel.svg',
      '9' => 'assets/icons/mustard.svg',
      '10' => 'assets/icons/almond.svg',
      '11' => 'assets/icons/peanuts.svg',
      '12' => 'assets/icons/sesame.svg',
      '13' => 'assets/icons/soya.svg',
      '14' => 'assets/icons/no-preservatives.svg',
      _ => throw Exception('Unknown allergen id: $id'),
    };
  }
}
