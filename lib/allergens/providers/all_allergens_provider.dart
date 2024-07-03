import 'package:men_you/allergens/domain/allergen.dart';
import 'package:men_you/allergens/repository/allergen_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_allergens_provider.g.dart';

@Riverpod(keepAlive: true)
FutureOr<List<Allergen>> allAllergens(AllAllergensRef ref) async {
  return await ref.watch(allergenRepositoryProvider).getAllAllergens();
}
