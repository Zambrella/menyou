import 'package:freezed_annotation/freezed_annotation.dart';

part 'allergen.g.dart';
part 'allergen.freezed.dart';

@freezed
class Allergen with _$Allergen {
  const factory Allergen({
    required String id,
    required String name,
    required String description,
  }) = _Allergen;

  factory Allergen.fromJson(Map<String, dynamic> json) => _$AllergenFromJson(json);
}
