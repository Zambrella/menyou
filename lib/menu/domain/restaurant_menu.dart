// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:uuid/uuid.dart';

part 'restaurant_menu.g.dart';
part 'restaurant_menu.freezed.dart';

@freezed
class RestaurantMenu with _$RestaurantMenu {
  @JsonSerializable(explicitToJson: true)
  const factory RestaurantMenu({
    required String id,
    List<MenuItem>? menuItems,
    String? name,
  }) = _RestaurantMenu;

  @JsonSerializable(explicitToJson: true)
  factory RestaurantMenu.empty() {
    return RestaurantMenu(
      id: const Uuid().v4(),
    );
  }

  const RestaurantMenu._();

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) => _$RestaurantMenuFromJson(json);

  RestaurantMenu addMenuItem(MenuItem menuItem) {
    return copyWith(
      menuItems: [...menuItems ?? [], menuItem],
    );
  }

  RestaurantMenu updateName(String name) {
    return copyWith(name: name);
  }
}
