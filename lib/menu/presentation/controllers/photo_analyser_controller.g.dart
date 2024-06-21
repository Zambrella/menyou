// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_analyser_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$photoAnalyserControllerHash() =>
    r'df0b9741778bd2cb541d975fb0064a5376de8e7d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [photoAnalyserController].
@ProviderFor(photoAnalyserController)
const photoAnalyserControllerProvider = PhotoAnalyserControllerFamily();

/// See also [photoAnalyserController].
class PhotoAnalyserControllerFamily extends Family<AsyncValue<List<MenuItem>>> {
  /// See also [photoAnalyserController].
  const PhotoAnalyserControllerFamily();

  /// See also [photoAnalyserController].
  PhotoAnalyserControllerProvider call(
    Photo photo,
  ) {
    return PhotoAnalyserControllerProvider(
      photo,
    );
  }

  @override
  PhotoAnalyserControllerProvider getProviderOverride(
    covariant PhotoAnalyserControllerProvider provider,
  ) {
    return call(
      provider.photo,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'photoAnalyserControllerProvider';
}

/// See also [photoAnalyserController].
class PhotoAnalyserControllerProvider
    extends AutoDisposeFutureProvider<List<MenuItem>> {
  /// See also [photoAnalyserController].
  PhotoAnalyserControllerProvider(
    Photo photo,
  ) : this._internal(
          (ref) => photoAnalyserController(
            ref as PhotoAnalyserControllerRef,
            photo,
          ),
          from: photoAnalyserControllerProvider,
          name: r'photoAnalyserControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$photoAnalyserControllerHash,
          dependencies: PhotoAnalyserControllerFamily._dependencies,
          allTransitiveDependencies:
              PhotoAnalyserControllerFamily._allTransitiveDependencies,
          photo: photo,
        );

  PhotoAnalyserControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.photo,
  }) : super.internal();

  final Photo photo;

  @override
  Override overrideWith(
    FutureOr<List<MenuItem>> Function(PhotoAnalyserControllerRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PhotoAnalyserControllerProvider._internal(
        (ref) => create(ref as PhotoAnalyserControllerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        photo: photo,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<MenuItem>> createElement() {
    return _PhotoAnalyserControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PhotoAnalyserControllerProvider && other.photo == photo;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, photo.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PhotoAnalyserControllerRef
    on AutoDisposeFutureProviderRef<List<MenuItem>> {
  /// The parameter `photo` of this provider.
  Photo get photo;
}

class _PhotoAnalyserControllerProviderElement
    extends AutoDisposeFutureProviderElement<List<MenuItem>>
    with PhotoAnalyserControllerRef {
  _PhotoAnalyserControllerProviderElement(super.provider);

  @override
  Photo get photo => (origin as PhotoAnalyserControllerProvider).photo;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
