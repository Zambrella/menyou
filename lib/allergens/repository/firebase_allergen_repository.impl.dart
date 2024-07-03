import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/domain/allergen_repository.abs.dart';

class FirebaseAllergenRepository implements AllergenRepository {
  const FirebaseAllergenRepository(
    this._firestore,
    this._auth,
    this._logger,
  );

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final Logger _logger;

  static const _allergyField = 'allergies';
  static const _intolleranceField = 'users';

  @override
  Future<List<Allergen>> getAllAllergens() async {
    // Taken from: https://www.food.gov.uk/sites/default/files/media/document/top-allergy-types.pdf
    return Future.value(
      const [
        Allergen(
          id: '1',
          name: 'Celery',
          description: 'This includes celery stalks, leaves, seeds and the root called celeriac.',
        ),
        Allergen(
          id: '2',
          name: 'Gluten',
          description: 'Wheat, rye, barley and some oats.',
        ),
        Allergen(
          id: '3',
          name: 'Crustacean',
          description: 'Crabs, lobster, prawns and scampi are crustaceans.',
        ),
        Allergen(
          id: '4',
          name: 'Egg',
          description: 'Eggs are often found in cakes, some meat products, mayonnaise, mousses, pasta, quiche, sauces and pastries',
        ),
        Allergen(
          id: '5',
          name: 'Fish',
          description: 'You will find this in some fish sauces, pizzas, relishes, salad dressings, stock cubes and Worcestershire sauce.',
        ),
        Allergen(
          id: '6',
          name: 'Lupin',
          description: 'Lupin is a type of legume that can be used in flour.',
        ),
        Allergen(
          id: '7',
          name: 'Milk',
          description: 'Milk is a common ingredient in butter, cheese, cream, milk powders and yoghurt.',
        ),
        Allergen(
          id: '8',
          name: 'Molluscs',
          description:
              'These include mussels, land snails, squid and whelks, but can also be found in oyster sauce or as an ingredient in fish stews.',
        ),
        Allergen(
          id: '9',
          name: 'Mustard',
          description: 'Liquid mustard, mustard powder and mustard seeds fall into this category.',
        ),
        Allergen(
          id: '10',
          name: 'Nuts',
          description:
              'Nuts are often found in bread, biscuits, crackers, desserts, nut powders (often used in Asian curries), stir-fried dishes, ice cream, marzipan (almond paste), nut oils and sauces.',
        ),
        Allergen(
          id: '11',
          name: 'Peanuts',
          description:
              'Peanuts are often used as an ingredient in biscuits, cakes, curries, desserts, sauces (such as satay sauce), as well as in groundnut oil and peanut flour.',
        ),
        Allergen(
          id: '12',
          name: 'Sesame',
          description: 'Sesame seeds are found in bread, breadsticks, houmous, sesame oil and tahini (sesame paste).',
        ),
        Allergen(
          id: '13',
          name: 'Soya',
          description:
              'Often found in bean curd, edamame beans, miso paste, textured soya protein, soya flour or tofu, soya is a staple ingredient in oriental food.',
        ),
        Allergen(
          id: '14',
          name: 'Sulphur dioxide',
          description:
              'This is used as a preservative in dried fruit, meat products, soft drinks and vegetables as well as in wine and beer.',
        ),
      ],
    );
  }

  @override
  Future<List<String>> getUserAllergies() async {
    try {
      final docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
      final doc = await docRef.get();
      if (!doc.exists || doc.data() == null) {
        _logger.d('No allergies found for user');
        return [];
      }
      final data = doc.data()![_allergyField] as List<String>;
      _logger.d('User allergies: $data');
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getUserIntollerances() async {
    try {
      final docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
      final doc = await docRef.get();
      if (!doc.exists || doc.data() == null) {
        _logger.d('No intollerances found for user');
        return [];
      }
      final data = doc.data()![_intolleranceField] as List<String>;
      _logger.d('User intollerances: $data');
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addUserAllergy(String allergenId) {
    // TODO: implement addUserAllergen
    throw UnimplementedError();
  }

  @override
  Future<void> addUserIntolerance(String allergenId) {
    // TODO: implement addUserIntolerance
    throw UnimplementedError();
  }

  @override
  Future<void> removeUserAllergy(String allergenId) {
    // TODO: implement removeUserAllergen
    throw UnimplementedError();
  }

  @override
  Future<void> removeUserIntolerance(String allergenId) {
    // TODO: implement removeUserIntolerance
    throw UnimplementedError();
  }
}
