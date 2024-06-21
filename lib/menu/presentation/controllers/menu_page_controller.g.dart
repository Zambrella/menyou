// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$menuPageControllerHash() =>
    r'18c10113d2dac54f68cbe1f35cf94b1f93304932';

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

abstract class _$MenuPageController
    extends BuildlessAutoDisposeAsyncNotifier<RestaurantMenu> {
  late final String menuId;
  late final RestaurantMenu? restaurantMenu;

  FutureOr<RestaurantMenu> build(
    String menuId,
    RestaurantMenu? restaurantMenu,
  );
}

/// See also [MenuPageController].
@ProviderFor(MenuPageController)
const menuPageControllerProvider = MenuPageControllerFamily();

/// See also [MenuPageController].
class MenuPageControllerFamily extends Family<AsyncValue<RestaurantMenu>> {
  /// See also [MenuPageController].
  const MenuPageControllerFamily();

  /// See also [MenuPageController].
  MenuPageControllerProvider call(
    String menuId,
    RestaurantMenu? restaurantMenu,
  ) {
    return MenuPageControllerProvider(
      menuId,
      restaurantMenu,
    );
  }

  @override
  MenuPageControllerProvider getProviderOverride(
    covariant MenuPageControllerProvider provider,
  ) {
    return call(
      provider.menuId,
      provider.restaurantMenu,
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
  String? get name => r'menuPageControllerProvider';
}

/// See also [MenuPageController].
class MenuPageControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    MenuPageController, RestaurantMenu> {
  /// See also [MenuPageController].
  MenuPageControllerProvider(
    String menuId,
    RestaurantMenu? restaurantMenu,
  ) : this._internal(
          () => MenuPageController()
            ..menuId = menuId
            ..restaurantMenu = restaurantMenu,
          from: menuPageControllerProvider,
          name: r'menuPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$menuPageControllerHash,
          dependencies: MenuPageControllerFamily._dependencies,
          allTransitiveDependencies:
              MenuPageControllerFamily._allTransitiveDependencies,
          menuId: menuId,
          restaurantMenu: restaurantMenu,
        );

  MenuPageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.menuId,
    required this.restaurantMenu,
  }) : super.internal();

  final String menuId;
  final RestaurantMenu? restaurantMenu;

  @override
  FutureOr<RestaurantMenu> runNotifierBuild(
    covariant MenuPageController notifier,
  ) {
    return notifier.build(
      menuId,
      restaurantMenu,
    );
  }

  @override
  Override overrideWith(MenuPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: MenuPageControllerProvider._internal(
        () => create()
          ..menuId = menuId
          ..restaurantMenu = restaurantMenu,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        menuId: menuId,
        restaurantMenu: restaurantMenu,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MenuPageController, RestaurantMenu>
      createElement() {
    return _MenuPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MenuPageControllerProvider &&
        other.menuId == menuId &&
        other.restaurantMenu == restaurantMenu;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, menuId.hashCode);
    hash = _SystemHash.combine(hash, restaurantMenu.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MenuPageControllerRef
    on AutoDisposeAsyncNotifierProviderRef<RestaurantMenu> {
  /// The parameter `menuId` of this provider.
  String get menuId;

  /// The parameter `restaurantMenu` of this provider.
  RestaurantMenu? get restaurantMenu;
}

class _MenuPageControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MenuPageController,
        RestaurantMenu> with MenuPageControllerRef {
  _MenuPageControllerProviderElement(super.provider);

  @override
  String get menuId => (origin as MenuPageControllerProvider).menuId;
  @override
  RestaurantMenu? get restaurantMenu =>
      (origin as MenuPageControllerProvider).restaurantMenu;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
