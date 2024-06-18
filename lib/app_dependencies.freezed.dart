// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_dependencies.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppDependencies {
  PackageInfo get packageInfo => throw _privateConstructorUsedError;
  BaseDeviceInfo get deviceInfo => throw _privateConstructorUsedError;
  SharedPreferences get sharedPreferences => throw _privateConstructorUsedError;
  Version get appVersion => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppDependenciesCopyWith<AppDependencies> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppDependenciesCopyWith<$Res> {
  factory $AppDependenciesCopyWith(
          AppDependencies value, $Res Function(AppDependencies) then) =
      _$AppDependenciesCopyWithImpl<$Res, AppDependencies>;
  @useResult
  $Res call(
      {PackageInfo packageInfo,
      BaseDeviceInfo deviceInfo,
      SharedPreferences sharedPreferences,
      Version appVersion});
}

/// @nodoc
class _$AppDependenciesCopyWithImpl<$Res, $Val extends AppDependencies>
    implements $AppDependenciesCopyWith<$Res> {
  _$AppDependenciesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageInfo = null,
    Object? deviceInfo = null,
    Object? sharedPreferences = null,
    Object? appVersion = null,
  }) {
    return _then(_value.copyWith(
      packageInfo: null == packageInfo
          ? _value.packageInfo
          : packageInfo // ignore: cast_nullable_to_non_nullable
              as PackageInfo,
      deviceInfo: null == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as BaseDeviceInfo,
      sharedPreferences: null == sharedPreferences
          ? _value.sharedPreferences
          : sharedPreferences // ignore: cast_nullable_to_non_nullable
              as SharedPreferences,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as Version,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppDependenciesImplCopyWith<$Res>
    implements $AppDependenciesCopyWith<$Res> {
  factory _$$AppDependenciesImplCopyWith(_$AppDependenciesImpl value,
          $Res Function(_$AppDependenciesImpl) then) =
      __$$AppDependenciesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {PackageInfo packageInfo,
      BaseDeviceInfo deviceInfo,
      SharedPreferences sharedPreferences,
      Version appVersion});
}

/// @nodoc
class __$$AppDependenciesImplCopyWithImpl<$Res>
    extends _$AppDependenciesCopyWithImpl<$Res, _$AppDependenciesImpl>
    implements _$$AppDependenciesImplCopyWith<$Res> {
  __$$AppDependenciesImplCopyWithImpl(
      _$AppDependenciesImpl _value, $Res Function(_$AppDependenciesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageInfo = null,
    Object? deviceInfo = null,
    Object? sharedPreferences = null,
    Object? appVersion = null,
  }) {
    return _then(_$AppDependenciesImpl(
      packageInfo: null == packageInfo
          ? _value.packageInfo
          : packageInfo // ignore: cast_nullable_to_non_nullable
              as PackageInfo,
      deviceInfo: null == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as BaseDeviceInfo,
      sharedPreferences: null == sharedPreferences
          ? _value.sharedPreferences
          : sharedPreferences // ignore: cast_nullable_to_non_nullable
              as SharedPreferences,
      appVersion: null == appVersion
          ? _value.appVersion
          : appVersion // ignore: cast_nullable_to_non_nullable
              as Version,
    ));
  }
}

/// @nodoc

class _$AppDependenciesImpl
    with DiagnosticableTreeMixin
    implements _AppDependencies {
  const _$AppDependenciesImpl(
      {required this.packageInfo,
      required this.deviceInfo,
      required this.sharedPreferences,
      required this.appVersion});

  @override
  final PackageInfo packageInfo;
  @override
  final BaseDeviceInfo deviceInfo;
  @override
  final SharedPreferences sharedPreferences;
  @override
  final Version appVersion;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppDependencies(packageInfo: $packageInfo, deviceInfo: $deviceInfo, sharedPreferences: $sharedPreferences, appVersion: $appVersion)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppDependencies'))
      ..add(DiagnosticsProperty('packageInfo', packageInfo))
      ..add(DiagnosticsProperty('deviceInfo', deviceInfo))
      ..add(DiagnosticsProperty('sharedPreferences', sharedPreferences))
      ..add(DiagnosticsProperty('appVersion', appVersion));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppDependenciesImpl &&
            (identical(other.packageInfo, packageInfo) ||
                other.packageInfo == packageInfo) &&
            (identical(other.deviceInfo, deviceInfo) ||
                other.deviceInfo == deviceInfo) &&
            (identical(other.sharedPreferences, sharedPreferences) ||
                other.sharedPreferences == sharedPreferences) &&
            (identical(other.appVersion, appVersion) ||
                other.appVersion == appVersion));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, packageInfo, deviceInfo, sharedPreferences, appVersion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppDependenciesImplCopyWith<_$AppDependenciesImpl> get copyWith =>
      __$$AppDependenciesImplCopyWithImpl<_$AppDependenciesImpl>(
          this, _$identity);
}

abstract class _AppDependencies implements AppDependencies {
  const factory _AppDependencies(
      {required final PackageInfo packageInfo,
      required final BaseDeviceInfo deviceInfo,
      required final SharedPreferences sharedPreferences,
      required final Version appVersion}) = _$AppDependenciesImpl;

  @override
  PackageInfo get packageInfo;
  @override
  BaseDeviceInfo get deviceInfo;
  @override
  SharedPreferences get sharedPreferences;
  @override
  Version get appVersion;
  @override
  @JsonKey(ignore: true)
  _$$AppDependenciesImplCopyWith<_$AppDependenciesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
