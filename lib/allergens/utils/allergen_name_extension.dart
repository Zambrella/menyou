import 'package:flutter/material.dart';
import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/l10n/gen_l10n/app_localizations.dart';

extension AllergenNameX on String {
  Allergen toAllergen() {
    return switch (toLowerCase()) {
      'celery' => const Allergen(
          id: '1',
          name: 'Celery',
          description: 'This includes celery stalks, leaves, seeds and the root called celeriac.',
        ),
      'gluten' => const Allergen(
          id: '2',
          name: 'Gluten',
          description: 'Wheat, rye, barley and some oats.',
        ),
      'crustacean' => const Allergen(
          id: '3',
          name: 'Crustacean',
          description: 'Crabs, lobster, prawns and scampi are crustaceans.',
        ),
      'egg' => const Allergen(
          id: '4',
          name: 'Egg',
          description: 'Eggs are often found in cakes, some meat products, mayonnaise, mousses, pasta, quiche, sauces and pastries',
        ),
      'fish' => const Allergen(
          id: '5',
          name: 'Fish',
          description: 'You will find this in some fish sauces, pizzas, relishes, salad dressings, stock cubes and Worcestershire sauce.',
        ),
      'lupin' => const Allergen(
          id: '6',
          name: 'Lupin',
          description: 'Lupin is a type of legume that can be used in flour.',
        ),
      'milk' => const Allergen(
          id: '7',
          name: 'Milk',
          description: 'Milk is a common ingredient in butter, cheese, cream, milk powders and yoghurt.',
        ),
      'molluscs' => const Allergen(
          id: '8',
          name: 'Molluscs',
          description:
              'These include mussels, land snails, squid and whelks, but can also be found in oyster sauce or as an ingredient in fish stews.',
        ),
      'mustard' => const Allergen(
          id: '9',
          name: 'Mustard',
          description: 'Liquid mustard, mustard powder and mustard seeds fall into this category.',
        ),
      'nuts' => const Allergen(
          id: '10',
          name: 'Nuts',
          description:
              'Nuts are often found in bread, biscuits, crackers, desserts, nut powders (often used in Asian curries), stir-fried dishes, ice cream, marzipan (almond paste), nut oils and sauces.',
        ),
      'peanuts' => const Allergen(
          id: '11',
          name: 'Peanuts',
          description:
              'Peanuts are often used as an ingredient in biscuits, cakes, curries, desserts, sauces (such as satay sauce), as well as in groundnut oil and peanut flour.',
        ),
      'sesame' => const Allergen(
          id: '12',
          name: 'Sesame',
          description: 'Sesame seeds are found in bread, breadsticks, houmous, sesame oil and tahini (sesame paste).',
        ),
      'soya' => const Allergen(
          id: '13',
          name: 'Soya',
          description:
              'Often found in bean curd, edamame beans, miso paste, textured soya protein, soya flour or tofu, soya is a staple ingredient in oriental food.',
        ),
      'sulphur dioxide' => const Allergen(
          id: '14',
          name: 'Sulphur dioxide',
          description:
              'This is used as a preservative in dried fruit, meat products, soft drinks and vegetables as well as in wine and beer.',
        ),
      _ => throw Exception('Unknown allergen name: $this'),
    };
  }
}

extension LocalizedAllergenX on Allergen {
  Allergen toLocale(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return switch (name.toLowerCase()) {
      'celery' => copyWith(name: l10n.celery, description: l10n.celeryDescription),
      'gluten' => copyWith(name: l10n.gluten, description: l10n.glutenDescription),
      'crustacean' => copyWith(name: l10n.crustacean, description: l10n.crustaceanDescription),
      'egg' => copyWith(name: l10n.egg, description: l10n.eggDescription),
      'fish' => copyWith(name: l10n.fish, description: l10n.fishDescription),
      'lupin' => copyWith(name: l10n.lupin, description: l10n.lupinDescription),
      'milk' => copyWith(name: l10n.milk, description: l10n.milkDescription),
      'molluscs' => copyWith(name: l10n.mollusc, description: l10n.molluscDescription),
      'mustard' => copyWith(name: l10n.mustard, description: l10n.mustardDescription),
      'nuts' => copyWith(name: l10n.nuts, description: l10n.nutsDescription),
      'peanuts' => copyWith(name: l10n.peanuts, description: l10n.peanutsDescription),
      'sesame' => copyWith(name: l10n.sesame, description: l10n.sesameDescription),
      'soya' => copyWith(name: l10n.soya, description: l10n.soyaDescription),
      'sulphur dioxide' => copyWith(name: l10n.sulphurDioxide, description: l10n.sulphurDioxideDescription),
      _ => throw Exception('Unknown allergen name: $this'),
    };
  }
}
