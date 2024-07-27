// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item_chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$menuItemChatControllerHash() =>
    r'73c0aca7d70829ce3b7e0721c916a511f27a2317';

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

abstract class _$MenuItemChatController
    extends BuildlessAsyncNotifier<MenuItemChat> {
  late final MenuItem menuItem;

  FutureOr<MenuItemChat> build(
    MenuItem menuItem,
  );
}

/// See also [MenuItemChatController].
@ProviderFor(MenuItemChatController)
const menuItemChatControllerProvider = MenuItemChatControllerFamily();

/// See also [MenuItemChatController].
class MenuItemChatControllerFamily extends Family<AsyncValue<MenuItemChat>> {
  /// See also [MenuItemChatController].
  const MenuItemChatControllerFamily();

  /// See also [MenuItemChatController].
  MenuItemChatControllerProvider call(
    MenuItem menuItem,
  ) {
    return MenuItemChatControllerProvider(
      menuItem,
    );
  }

  @override
  MenuItemChatControllerProvider getProviderOverride(
    covariant MenuItemChatControllerProvider provider,
  ) {
    return call(
      provider.menuItem,
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
  String? get name => r'menuItemChatControllerProvider';
}

/// See also [MenuItemChatController].
class MenuItemChatControllerProvider
    extends AsyncNotifierProviderImpl<MenuItemChatController, MenuItemChat> {
  /// See also [MenuItemChatController].
  MenuItemChatControllerProvider(
    MenuItem menuItem,
  ) : this._internal(
          () => MenuItemChatController()..menuItem = menuItem,
          from: menuItemChatControllerProvider,
          name: r'menuItemChatControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$menuItemChatControllerHash,
          dependencies: MenuItemChatControllerFamily._dependencies,
          allTransitiveDependencies:
              MenuItemChatControllerFamily._allTransitiveDependencies,
          menuItem: menuItem,
        );

  MenuItemChatControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.menuItem,
  }) : super.internal();

  final MenuItem menuItem;

  @override
  FutureOr<MenuItemChat> runNotifierBuild(
    covariant MenuItemChatController notifier,
  ) {
    return notifier.build(
      menuItem,
    );
  }

  @override
  Override overrideWith(MenuItemChatController Function() create) {
    return ProviderOverride(
      origin: this,
      override: MenuItemChatControllerProvider._internal(
        () => create()..menuItem = menuItem,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        menuItem: menuItem,
      ),
    );
  }

  @override
  AsyncNotifierProviderElement<MenuItemChatController, MenuItemChat>
      createElement() {
    return _MenuItemChatControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MenuItemChatControllerProvider &&
        other.menuItem == menuItem;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, menuItem.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MenuItemChatControllerRef on AsyncNotifierProviderRef<MenuItemChat> {
  /// The parameter `menuItem` of this provider.
  MenuItem get menuItem;
}

class _MenuItemChatControllerProviderElement
    extends AsyncNotifierProviderElement<MenuItemChatController, MenuItemChat>
    with MenuItemChatControllerRef {
  _MenuItemChatControllerProviderElement(super.provider);

  @override
  MenuItem get menuItem => (origin as MenuItemChatControllerProvider).menuItem;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
