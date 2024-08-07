import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'allergen.g.dart';
part 'allergen.freezed.dart';

@Freezed(equal: false)
class Allergen extends Equatable with _$Allergen {
  const factory Allergen({
    required String id,
    required String name,
    required String description,
  }) = _Allergen;

  const Allergen._();

  factory Allergen.fromJson(Map<String, dynamic> json) => _$AllergenFromJson(json);

  @override
  List<Object?> get props => [id];
}
