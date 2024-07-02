// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'restaurant_menu.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RestaurantMenu _$RestaurantMenuFromJson(Map<String, dynamic> json) {
  return _RestaurantMenu.fromJson(json);
}

/// @nodoc
mixin _$RestaurantMenu {
  String get id => throw _privateConstructorUsedError;
  List<MenuItem>? get menuItems => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RestaurantMenuCopyWith<RestaurantMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RestaurantMenuCopyWith<$Res> {
  factory $RestaurantMenuCopyWith(
          RestaurantMenu value, $Res Function(RestaurantMenu) then) =
      _$RestaurantMenuCopyWithImpl<$Res, RestaurantMenu>;
  @useResult
  $Res call({String id, List<MenuItem>? menuItems, String? name});
}

/// @nodoc
class _$RestaurantMenuCopyWithImpl<$Res, $Val extends RestaurantMenu>
    implements $RestaurantMenuCopyWith<$Res> {
  _$RestaurantMenuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItems = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      menuItems: freezed == menuItems
          ? _value.menuItems
          : menuItems // ignore: cast_nullable_to_non_nullable
              as List<MenuItem>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RestaurantMenuImplCopyWith<$Res>
    implements $RestaurantMenuCopyWith<$Res> {
  factory _$$RestaurantMenuImplCopyWith(_$RestaurantMenuImpl value,
          $Res Function(_$RestaurantMenuImpl) then) =
      __$$RestaurantMenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, List<MenuItem>? menuItems, String? name});
}

/// @nodoc
class __$$RestaurantMenuImplCopyWithImpl<$Res>
    extends _$RestaurantMenuCopyWithImpl<$Res, _$RestaurantMenuImpl>
    implements _$$RestaurantMenuImplCopyWith<$Res> {
  __$$RestaurantMenuImplCopyWithImpl(
      _$RestaurantMenuImpl _value, $Res Function(_$RestaurantMenuImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? menuItems = freezed,
    Object? name = freezed,
  }) {
    return _then(_$RestaurantMenuImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      menuItems: freezed == menuItems
          ? _value._menuItems
          : menuItems // ignore: cast_nullable_to_non_nullable
              as List<MenuItem>?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$RestaurantMenuImpl extends _RestaurantMenu {
  const _$RestaurantMenuImpl(
      {required this.id, final List<MenuItem>? menuItems, this.name})
      : _menuItems = menuItems,
        super._();

  factory _$RestaurantMenuImpl.fromJson(Map<String, dynamic> json) =>
      _$$RestaurantMenuImplFromJson(json);

  @override
  final String id;
  final List<MenuItem>? _menuItems;
  @override
  List<MenuItem>? get menuItems {
    final value = _menuItems;
    if (value == null) return null;
    if (_menuItems is EqualUnmodifiableListView) return _menuItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? name;

  @override
  String toString() {
    return 'RestaurantMenu(id: $id, menuItems: $menuItems, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RestaurantMenuImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality()
                .equals(other._menuItems, _menuItems) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, const DeepCollectionEquality().hash(_menuItems), name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RestaurantMenuImplCopyWith<_$RestaurantMenuImpl> get copyWith =>
      __$$RestaurantMenuImplCopyWithImpl<_$RestaurantMenuImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RestaurantMenuImplToJson(
      this,
    );
  }
}

abstract class _RestaurantMenu extends RestaurantMenu {
  const factory _RestaurantMenu(
      {required final String id,
      final List<MenuItem>? menuItems,
      final String? name}) = _$RestaurantMenuImpl;
  const _RestaurantMenu._() : super._();

  factory _RestaurantMenu.fromJson(Map<String, dynamic> json) =
      _$RestaurantMenuImpl.fromJson;

  @override
  String get id;
  @override
  List<MenuItem>? get menuItems;
  @override
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$RestaurantMenuImplCopyWith<_$RestaurantMenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
