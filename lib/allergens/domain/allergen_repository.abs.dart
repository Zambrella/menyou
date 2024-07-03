import 'package:men_you/allergens/domain/allergen.dart';

abstract class AllergenRepository {
  /// Returns a list of all allergens in the system.
  Future<List<Allergen>> getAllAllergens();

  /// Returns a list of the user's saved allergens.
  /// Returned as a list of [Allergen] ids.
  Future<List<String>> getUserAllergies();

  /// Returns a list of the user's saved intolerances.
  /// Returned as a list of [Allergen] ids.
  Future<List<String>> getUserIntollerances();

  /// Adds an allergen to the user's saved allergens.
  Future<void> addUserAllergy(String allergenId);

  /// Removes an allergen from the user's saved allergens.
  Future<void> removeUserAllergy(String allergenId);

  /// Adds an allergen to the user's saved intolerances.
  Future<void> addUserIntolerance(String allergenId);

  /// Removes an allergen from the user's saved intolerances.
  Future<void> removeUserIntolerance(String allergenId);
}
