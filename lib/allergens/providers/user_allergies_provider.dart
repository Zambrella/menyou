import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/providers/all_allergens_provider.dart';
import 'package:men_you/allergens/repository/allergen_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_allergies_provider.g.dart';

@riverpod
FutureOr<List<Allergen>> userAllergies(UserAllergiesRef ref) async {
  final allAllergens = await ref.watch(allAllergensProvider.future);
  final userAllergenIds = await ref.watch(allergenRepositoryProvider).getUserAllergies();
  final userAllergens = allAllergens.where((allergen) => userAllergenIds.contains(allergen.id)).toList();
  return userAllergens;
}
