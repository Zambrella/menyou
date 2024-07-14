import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:men_you/account/domain/account_repository.abs.dart';

class FirebaseAccountRepository implements AccountRepository {
  const FirebaseAccountRepository(
    this._firebaseAuth,
    this._firestore,
  );

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  @override
  Future<void> createAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) {
        throw Exception('User is not signed in');
      }
      // Create an empty user document
      await _firestore.collection('users').doc(user.uid).set({});
    } catch (e) {
      rethrow;
    }
  }
}
