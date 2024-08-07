import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/domain/allergen_repository.abs.dart';
import 'package:men_you/allergens/utils/allergen_name_extension.dart';

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
  static const _intolleranceField = 'intollerances';

  @override
  Future<List<Allergen>> getAllAllergens() async {
    // Taken from: https://www.food.gov.uk/sites/default/files/media/document/top-allergy-types.pdf
    return Future.value(
      [
        'Celery',
        'Gluten',
        'Crustacean',
        'Egg',
        'Fish',
        'Lupin',
        'Milk',
        'Molluscs',
        'Mustard',
        'Nuts',
        'Peanuts',
        'Sesame',
        'Soya',
        'Sulphur dioxide',
      ].map((e) => e.toAllergen()).toList(),
    );
  }

  @override
  Future<List<String>> getUserAllergies() async {
    try {
      final docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
      final doc = await docRef.get();
      if (!doc.exists || doc.data()?[_allergyField] == null) {
        _logger.d('No allergies found for user');
        return [];
      }
      final data = (doc.data()![_allergyField] as List<dynamic>).map((e) => e.toString()).toList();
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
      if (!doc.exists || doc.data()?[_intolleranceField] == null) {
        _logger.d('No intollerances found for user');
        return [];
      }
      final data = (doc.data()![_intolleranceField] as List<dynamic>).map((e) => e.toString()).toList();
      _logger.d('User intollerances: $data');
      return data;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addUserAllergy(String allergenId) async {
    try {
      final docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
      await docRef.update({
        _allergyField: FieldValue.arrayUnion([allergenId]),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> addUserIntolerance(String allergenId) async {
    try {
      final docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
      await docRef.update({
        _intolleranceField: FieldValue.arrayUnion([allergenId]),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeUserAllergy(String allergenId) async {
    try {
      final docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
      await docRef.update({
        _allergyField: FieldValue.arrayRemove([allergenId]),
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> removeUserIntolerance(String allergenId) async {
    try {
      final docRef = _firestore.collection('users').doc(_auth.currentUser!.uid);
      await docRef.update({
        _intolleranceField: FieldValue.arrayRemove([allergenId]),
      });
    } catch (e) {
      rethrow;
    }
  }
}
