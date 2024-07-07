import 'package:freezed_annotation/freezed_annotation.dart';

part 'allergen.g.dart';
part 'allergen.freezed.dart';

@freezed
class Allergen with _$Allergen {
  const factory Allergen({
    required String id,
    required String name,
    required String description,
  }) = _Allergen;

  factory Allergen.fromJson(Map<String, dynamic> json) => _$AllergenFromJson(json);

  // TODO: Move this to an extension and pass in BuildContext so it can be localised
  factory Allergen.fromName(String name) {
    return switch (name.toLowerCase()) {
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
      _ => throw Exception('Unknown allergen name: $name'),
    };
  }
}
