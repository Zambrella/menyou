// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allergen.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Allergen _$AllergenFromJson(Map<String, dynamic> json) {
  return _Allergen.fromJson(json);
}

/// @nodoc
mixin _$Allergen {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AllergenCopyWith<Allergen> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergenCopyWith<$Res> {
  factory $AllergenCopyWith(Allergen value, $Res Function(Allergen) then) =
      _$AllergenCopyWithImpl<$Res, Allergen>;
  @useResult
  $Res call({String id, String name, String description});
}

/// @nodoc
class _$AllergenCopyWithImpl<$Res, $Val extends Allergen>
    implements $AllergenCopyWith<$Res> {
  _$AllergenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllergenImplCopyWith<$Res>
    implements $AllergenCopyWith<$Res> {
  factory _$$AllergenImplCopyWith(
          _$AllergenImpl value, $Res Function(_$AllergenImpl) then) =
      __$$AllergenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String description});
}

/// @nodoc
class __$$AllergenImplCopyWithImpl<$Res>
    extends _$AllergenCopyWithImpl<$Res, _$AllergenImpl>
    implements _$$AllergenImplCopyWith<$Res> {
  __$$AllergenImplCopyWithImpl(
      _$AllergenImpl _value, $Res Function(_$AllergenImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$AllergenImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AllergenImpl extends _Allergen {
  const _$AllergenImpl(
      {required this.id, required this.name, required this.description})
      : super._();

  factory _$AllergenImpl.fromJson(Map<String, dynamic> json) =>
      _$$AllergenImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergenImplCopyWith<_$AllergenImpl> get copyWith =>
      __$$AllergenImplCopyWithImpl<_$AllergenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AllergenImplToJson(
      this,
    );
  }
}

abstract class _Allergen extends Allergen {
  const factory _Allergen(
      {required final String id,
      required final String name,
      required final String description}) = _$AllergenImpl;
  const _Allergen._() : super._();

  factory _Allergen.fromJson(Map<String, dynamic> json) =
      _$AllergenImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  @JsonKey(ignore: true)
  _$$AllergenImplCopyWith<_$AllergenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
