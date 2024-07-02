// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RestaurantMenuImpl _$$RestaurantMenuImplFromJson(Map<String, dynamic> json) =>
    _$RestaurantMenuImpl(
      id: json['id'] as String,
      menuItems: (json['menuItems'] as List<dynamic>?)
          ?.map((e) => MenuItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$RestaurantMenuImplToJson(
        _$RestaurantMenuImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'menuItems': instance.menuItems?.map((e) => e.toJson()).toList(),
      'name': instance.name,
    };
