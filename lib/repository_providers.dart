import 'package:analytics_core/analytics_core.dart';
import 'package:auth_firebase/auth_firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_privacy/data_privacy.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:men_you/app_dependencies.dart';
import 'package:purchases_core/purchases_core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  // requiredValue is possible because `appDependenciesProvider` is loaded in `lib/app.dart`
  return ref.watch(appDependenciesProvider.select((deps) => deps.requireValue.sharedPreferences));
}

@Riverpod(keepAlive: true)
FirebaseAuthRepository authRepository(AuthRepositoryRef ref) {
  return FirebaseAuthRepository(ref.watch(firebaseAuthProvider));
}

@Riverpod(keepAlive: true)
AnalyticsRepository analyticsRepository(AnalyticsRepositoryRef ref) {
  return FakeAnalyticsRepository();
}

@Riverpod(keepAlive: true)
PurchasesRepository purchasesRepository(PurchasesRepositoryRef ref) {
  return FakePurchasesRepository();
}

@Riverpod(keepAlive: true)
DataPrivacyRepository dataPrivacyRepository(DataPrivacyRepositoryRef ref) {
  return DataPrivacyRepository(ref.watch(sharedPreferencesProvider));
}

@Riverpod(keepAlive: true)
GenerativeModel aiModel(AiModelRef ref) {
  return FirebaseVertexAI.instanceFor(location: 'europe-west2').generativeModel(
    model: 'gemini-1.5-pro',
    generationConfig: GenerationConfig(),
  );
}

@Riverpod(keepAlive: true)
FirebaseFirestore firestore(FirestoreRef ref) {
  return FirebaseFirestore.instance;
}

@Riverpod(keepAlive: true)
FirebaseAuth firebaseAuth(FirebaseAuthRef ref) {
  return FirebaseAuth.instance;
}
