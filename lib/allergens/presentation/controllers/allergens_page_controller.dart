import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/domain/allergen_states.dart';
import 'package:men_you/allergens/providers/all_allergens_provider.dart';
import 'package:men_you/allergens/providers/user_allergies_provider.dart';
import 'package:men_you/allergens/providers/user_intolerances_provider.dart';
import 'package:men_you/allergens/repository/allergen_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'allergens_page_controller.g.dart';

@riverpod
class AllergensPageController extends _$AllergensPageController {
  @override
  FutureOr<List<(Allergen, AllergenStates)>> build() async {
    final allAllergens = await ref.watch(allAllergensProvider.future);
    final userAllergies = await ref.watch(userAllergiesProvider.future);
    final userIntolerances = await ref.watch(userIntolerancesProvider.future);
    final allergensAndState = allAllergens.map((allergen) {
      if (userAllergies.contains(allergen)) {
        return (allergen, AllergenStates.allergic);
      } else if (userIntolerances.contains(allergen)) {
        return (allergen, AllergenStates.intolerant);
      } else {
        return (allergen, AllergenStates.tolerant);
      }
    }).toList();
    return allergensAndState;
  }

  Future<void> addAllergy(Allergen allergen) async {
    state = AsyncData(
      state.requireValue.map((e) {
        if (e.$1 == allergen) {
          return (e.$1, AllergenStates.allergic);
        }
        return e;
      }).toList(),
    );
    await ref.read(allergenRepositoryProvider).addUserAllergy(allergen.id);
    await ref.read(allergenRepositoryProvider).removeUserIntolerance(allergen.id);
  }

  Future<void> removeAllergy(Allergen allergen) async {
    state = AsyncData(
      state.requireValue.map((e) {
        if (e.$1 == allergen) {
          return (e.$1, AllergenStates.tolerant);
        }
        return e;
      }).toList(),
    );
    await ref.read(allergenRepositoryProvider).removeUserAllergy(allergen.id);
  }

  Future<void> addIntolerance(Allergen allergen) async {
    state = AsyncData(
      state.requireValue.map((e) {
        if (e.$1 == allergen) {
          return (e.$1, AllergenStates.intolerant);
        }
        return e;
      }).toList(),
    );
    await ref.read(allergenRepositoryProvider).addUserIntolerance(allergen.id);
    await ref.read(allergenRepositoryProvider).removeUserAllergy(allergen.id);
  }

  Future<void> removeIntolerance(Allergen allergen) async {
    state = AsyncData(
      state.requireValue.map((e) {
        if (e.$1 == allergen) {
          return (e.$1, AllergenStates.tolerant);
        }
        return e;
      }).toList(),
    );
    await ref.read(allergenRepositoryProvider).removeUserIntolerance(allergen.id);
  }
}
