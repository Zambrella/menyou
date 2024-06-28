// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'photo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Photo {
  String get photoName => throw _privateConstructorUsedError;
  Uint8List get photoData => throw _privateConstructorUsedError;
  String get mimeType => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PhotoCopyWith<Photo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoCopyWith<$Res> {
  factory $PhotoCopyWith(Photo value, $Res Function(Photo) then) =
      _$PhotoCopyWithImpl<$Res, Photo>;
  @useResult
  $Res call({String photoName, Uint8List photoData, String mimeType});
}

/// @nodoc
class _$PhotoCopyWithImpl<$Res, $Val extends Photo>
    implements $PhotoCopyWith<$Res> {
  _$PhotoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoName = null,
    Object? photoData = null,
    Object? mimeType = null,
  }) {
    return _then(_value.copyWith(
      photoName: null == photoName
          ? _value.photoName
          : photoName // ignore: cast_nullable_to_non_nullable
              as String,
      photoData: null == photoData
          ? _value.photoData
          : photoData // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoImplCopyWith<$Res> implements $PhotoCopyWith<$Res> {
  factory _$$PhotoImplCopyWith(
          _$PhotoImpl value, $Res Function(_$PhotoImpl) then) =
      __$$PhotoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String photoName, Uint8List photoData, String mimeType});
}

/// @nodoc
class __$$PhotoImplCopyWithImpl<$Res>
    extends _$PhotoCopyWithImpl<$Res, _$PhotoImpl>
    implements _$$PhotoImplCopyWith<$Res> {
  __$$PhotoImplCopyWithImpl(
      _$PhotoImpl _value, $Res Function(_$PhotoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? photoName = null,
    Object? photoData = null,
    Object? mimeType = null,
  }) {
    return _then(_$PhotoImpl(
      photoName: null == photoName
          ? _value.photoName
          : photoName // ignore: cast_nullable_to_non_nullable
              as String,
      photoData: null == photoData
          ? _value.photoData
          : photoData // ignore: cast_nullable_to_non_nullable
              as Uint8List,
      mimeType: null == mimeType
          ? _value.mimeType
          : mimeType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PhotoImpl with DiagnosticableTreeMixin implements _Photo {
  const _$PhotoImpl(
      {required this.photoName,
      required this.photoData,
      this.mimeType = 'image/png'});

  @override
  final String photoName;
  @override
  final Uint8List photoData;
  @override
  @JsonKey()
  final String mimeType;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Photo(photoName: $photoName, photoData: $photoData, mimeType: $mimeType)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Photo'))
      ..add(DiagnosticsProperty('photoName', photoName))
      ..add(DiagnosticsProperty('photoData', photoData))
      ..add(DiagnosticsProperty('mimeType', mimeType));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoImpl &&
            (identical(other.photoName, photoName) ||
                other.photoName == photoName) &&
            const DeepCollectionEquality().equals(other.photoData, photoData) &&
            (identical(other.mimeType, mimeType) ||
                other.mimeType == mimeType));
  }

  @override
  int get hashCode => Object.hash(runtimeType, photoName,
      const DeepCollectionEquality().hash(photoData), mimeType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      __$$PhotoImplCopyWithImpl<_$PhotoImpl>(this, _$identity);
}

abstract class _Photo implements Photo {
  const factory _Photo(
      {required final String photoName,
      required final Uint8List photoData,
      final String mimeType}) = _$PhotoImpl;

  @override
  String get photoName;
  @override
  Uint8List get photoData;
  @override
  String get mimeType;
  @override
  @JsonKey(ignore: true)
  _$$PhotoImplCopyWith<_$PhotoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
