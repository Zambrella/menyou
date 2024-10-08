// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

MenuItem _$MenuItemFromJson(Map<String, dynamic> json) {
  switch (json['runtimeType']) {
    case 'unprocessed':
      return UnprocessedMenuItem.fromJson(json);
    case 'processed':
      return ProcessedMenuItem.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'runtimeType', 'MenuItem',
          'Invalid union type "${json['runtimeType']}"!');
  }
}

/// @nodoc
mixin _$MenuItem {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String? subtitle)
        unprocessed,
    required TResult Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)
        processed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String? subtitle)? unprocessed,
    TResult? Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)?
        processed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String? subtitle)? unprocessed,
    TResult Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)?
        processed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnprocessedMenuItem value) unprocessed,
    required TResult Function(ProcessedMenuItem value) processed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnprocessedMenuItem value)? unprocessed,
    TResult? Function(ProcessedMenuItem value)? processed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnprocessedMenuItem value)? unprocessed,
    TResult Function(ProcessedMenuItem value)? processed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MenuItemCopyWith<MenuItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemCopyWith<$Res> {
  factory $MenuItemCopyWith(MenuItem value, $Res Function(MenuItem) then) =
      _$MenuItemCopyWithImpl<$Res, MenuItem>;
  @useResult
  $Res call({String id, String title, String? subtitle});
}

/// @nodoc
class _$MenuItemCopyWithImpl<$Res, $Val extends MenuItem>
    implements $MenuItemCopyWith<$Res> {
  _$MenuItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UnprocessedMenuItemImplCopyWith<$Res>
    implements $MenuItemCopyWith<$Res> {
  factory _$$UnprocessedMenuItemImplCopyWith(_$UnprocessedMenuItemImpl value,
          $Res Function(_$UnprocessedMenuItemImpl) then) =
      __$$UnprocessedMenuItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String? subtitle});
}

/// @nodoc
class __$$UnprocessedMenuItemImplCopyWithImpl<$Res>
    extends _$MenuItemCopyWithImpl<$Res, _$UnprocessedMenuItemImpl>
    implements _$$UnprocessedMenuItemImplCopyWith<$Res> {
  __$$UnprocessedMenuItemImplCopyWithImpl(_$UnprocessedMenuItemImpl _value,
      $Res Function(_$UnprocessedMenuItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
  }) {
    return _then(_$UnprocessedMenuItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UnprocessedMenuItemImpl implements UnprocessedMenuItem {
  const _$UnprocessedMenuItemImpl(
      {required this.id,
      required this.title,
      required this.subtitle,
      final String? $type})
      : $type = $type ?? 'unprocessed';

  factory _$UnprocessedMenuItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$UnprocessedMenuItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MenuItem.unprocessed(id: $id, title: $title, subtitle: $subtitle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnprocessedMenuItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, subtitle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UnprocessedMenuItemImplCopyWith<_$UnprocessedMenuItemImpl> get copyWith =>
      __$$UnprocessedMenuItemImplCopyWithImpl<_$UnprocessedMenuItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String? subtitle)
        unprocessed,
    required TResult Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)
        processed,
  }) {
    return unprocessed(id, title, subtitle);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String? subtitle)? unprocessed,
    TResult? Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)?
        processed,
  }) {
    return unprocessed?.call(id, title, subtitle);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String? subtitle)? unprocessed,
    TResult Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)?
        processed,
    required TResult orElse(),
  }) {
    if (unprocessed != null) {
      return unprocessed(id, title, subtitle);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnprocessedMenuItem value) unprocessed,
    required TResult Function(ProcessedMenuItem value) processed,
  }) {
    return unprocessed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnprocessedMenuItem value)? unprocessed,
    TResult? Function(ProcessedMenuItem value)? processed,
  }) {
    return unprocessed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnprocessedMenuItem value)? unprocessed,
    TResult Function(ProcessedMenuItem value)? processed,
    required TResult orElse(),
  }) {
    if (unprocessed != null) {
      return unprocessed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$UnprocessedMenuItemImplToJson(
      this,
    );
  }
}

abstract class UnprocessedMenuItem implements MenuItem {
  const factory UnprocessedMenuItem(
      {required final String id,
      required final String title,
      required final String? subtitle}) = _$UnprocessedMenuItemImpl;

  factory UnprocessedMenuItem.fromJson(Map<String, dynamic> json) =
      _$UnprocessedMenuItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  @JsonKey(ignore: true)
  _$$UnprocessedMenuItemImplCopyWith<_$UnprocessedMenuItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ProcessedMenuItemImplCopyWith<$Res>
    implements $MenuItemCopyWith<$Res> {
  factory _$$ProcessedMenuItemImplCopyWith(_$ProcessedMenuItemImpl value,
          $Res Function(_$ProcessedMenuItemImpl) then) =
      __$$ProcessedMenuItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String? subtitle,
      String description,
      List<String> allergens,
      bool isVegetarian,
      bool isVegan});
}

/// @nodoc
class __$$ProcessedMenuItemImplCopyWithImpl<$Res>
    extends _$MenuItemCopyWithImpl<$Res, _$ProcessedMenuItemImpl>
    implements _$$ProcessedMenuItemImplCopyWith<$Res> {
  __$$ProcessedMenuItemImplCopyWithImpl(_$ProcessedMenuItemImpl _value,
      $Res Function(_$ProcessedMenuItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? description = null,
    Object? allergens = null,
    Object? isVegetarian = null,
    Object? isVegan = null,
  }) {
    return _then(_$ProcessedMenuItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: freezed == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String?,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      allergens: null == allergens
          ? _value._allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isVegetarian: null == isVegetarian
          ? _value.isVegetarian
          : isVegetarian // ignore: cast_nullable_to_non_nullable
              as bool,
      isVegan: null == isVegan
          ? _value.isVegan
          : isVegan // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProcessedMenuItemImpl implements ProcessedMenuItem {
  const _$ProcessedMenuItemImpl(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.description,
      required final List<String> allergens,
      this.isVegetarian = false,
      this.isVegan = false,
      final String? $type})
      : _allergens = allergens,
        $type = $type ?? 'processed';

  factory _$ProcessedMenuItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProcessedMenuItemImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String description;
  final List<String> _allergens;
  @override
  List<String> get allergens {
    if (_allergens is EqualUnmodifiableListView) return _allergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergens);
  }

  @override
  @JsonKey()
  final bool isVegetarian;
  @override
  @JsonKey()
  final bool isVegan;

  @JsonKey(name: 'runtimeType')
  final String $type;

  @override
  String toString() {
    return 'MenuItem.processed(id: $id, title: $title, subtitle: $subtitle, description: $description, allergens: $allergens, isVegetarian: $isVegetarian, isVegan: $isVegan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessedMenuItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._allergens, _allergens) &&
            (identical(other.isVegetarian, isVegetarian) ||
                other.isVegetarian == isVegetarian) &&
            (identical(other.isVegan, isVegan) || other.isVegan == isVegan));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, subtitle, description,
      const DeepCollectionEquality().hash(_allergens), isVegetarian, isVegan);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessedMenuItemImplCopyWith<_$ProcessedMenuItemImpl> get copyWith =>
      __$$ProcessedMenuItemImplCopyWithImpl<_$ProcessedMenuItemImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String id, String title, String? subtitle)
        unprocessed,
    required TResult Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)
        processed,
  }) {
    return processed(
        id, title, subtitle, description, allergens, isVegetarian, isVegan);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String id, String title, String? subtitle)? unprocessed,
    TResult? Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)?
        processed,
  }) {
    return processed?.call(
        id, title, subtitle, description, allergens, isVegetarian, isVegan);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String id, String title, String? subtitle)? unprocessed,
    TResult Function(
            String id,
            String title,
            String? subtitle,
            String description,
            List<String> allergens,
            bool isVegetarian,
            bool isVegan)?
        processed,
    required TResult orElse(),
  }) {
    if (processed != null) {
      return processed(
          id, title, subtitle, description, allergens, isVegetarian, isVegan);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UnprocessedMenuItem value) unprocessed,
    required TResult Function(ProcessedMenuItem value) processed,
  }) {
    return processed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UnprocessedMenuItem value)? unprocessed,
    TResult? Function(ProcessedMenuItem value)? processed,
  }) {
    return processed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UnprocessedMenuItem value)? unprocessed,
    TResult Function(ProcessedMenuItem value)? processed,
    required TResult orElse(),
  }) {
    if (processed != null) {
      return processed(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ProcessedMenuItemImplToJson(
      this,
    );
  }
}

abstract class ProcessedMenuItem implements MenuItem {
  const factory ProcessedMenuItem(
      {required final String id,
      required final String title,
      required final String? subtitle,
      required final String description,
      required final List<String> allergens,
      final bool isVegetarian,
      final bool isVegan}) = _$ProcessedMenuItemImpl;

  factory ProcessedMenuItem.fromJson(Map<String, dynamic> json) =
      _$ProcessedMenuItemImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  String get description;
  List<String> get allergens;
  bool get isVegetarian;
  bool get isVegan;
  @override
  @JsonKey(ignore: true)
  _$$ProcessedMenuItemImplCopyWith<_$ProcessedMenuItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
