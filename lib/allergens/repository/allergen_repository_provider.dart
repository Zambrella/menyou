import 'package:men_you/allergens/domain/allergen_repository.abs.dart';
import 'package:men_you/allergens/repository/firebase_allergen_repository.impl.dart';
import 'package:men_you/app_dependencies.dart';
import 'package:men_you/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'allergen_repository_provider.g.dart';

@Riverpod(keepAlive: true)
AllergenRepository allergenRepository(AllergenRepositoryRef ref) {
  return FirebaseAllergenRepository(
    ref.watch(firestoreProvider),
    ref.watch(firebaseAuthProvider),
    ref.watch(loggerProvider),
  );
}
