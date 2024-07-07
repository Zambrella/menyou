import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';
import 'package:men_you/allergens/providers/user_allergies_provider.dart';
import 'package:men_you/allergens/providers/user_intolerances_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_allergies_and_intolerances_provider.g.dart';

@riverpod
FutureOr<Map<AllergenStates, List<Allergen>>> userAllergiesAndIntolerances(UserAllergiesAndIntolerancesRef ref) async {
  final allergiesAndIntolerances = <AllergenStates, List<Allergen>>{};
  allergiesAndIntolerances[AllergenStates.allergic] = await ref.watch(userAllergiesProvider.future);
  allergiesAndIntolerances[AllergenStates.intolerant] = await ref.watch(userIntolerancesProvider.future);
  return allergiesAndIntolerances;
}
