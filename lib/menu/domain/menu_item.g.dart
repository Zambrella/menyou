// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UnprocessedMenuItemImpl _$$UnprocessedMenuItemImplFromJson(
        Map<String, dynamic> json) =>
    _$UnprocessedMenuItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$UnprocessedMenuItemImplToJson(
        _$UnprocessedMenuItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'runtimeType': instance.$type,
    };

_$ProcessedMenuItemImpl _$$ProcessedMenuItemImplFromJson(
        Map<String, dynamic> json) =>
    _$ProcessedMenuItemImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      description: json['description'] as String,
      allergens:
          (json['allergens'] as List<dynamic>).map((e) => e as String).toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$ProcessedMenuItemImplToJson(
        _$ProcessedMenuItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'description': instance.description,
      'allergens': instance.allergens,
      'runtimeType': instance.$type,
    };
