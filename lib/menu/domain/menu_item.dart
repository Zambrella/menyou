import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.g.dart';
part 'menu_item.freezed.dart';

@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem.unprocessed({
    required String id,
    required String title,
    required String? subtitle,
  }) = UnprocessedMenuItem;

  const factory MenuItem.processed({
    required String id,
    required String title,
    required String? subtitle,
    required String description,
    required List<String> allergens,
    @Default(false) bool isVegetarian,
    @Default(false) bool isVegan,
  }) = ProcessedMenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);

  static String getUnprocessedSchema() {
    final schema = {
      'type': 'object',
      'properties': {
        'title': {
          'type': 'string',
          'description': 'The title of the menu item',
        },
        'subtitle': {
          'type': 'string',
          'description': 'The subtitle of the menu item',
        },
      },
      'required': [
        'title',
      ],
    };
    return jsonEncode(schema);
  }

  static String getProcessedSchema() {
    final schema = {
      'type': 'object',
      'properties': {
        'description': {
          'type': 'string',
          'description':
              'A simple description of the menu item. Any parts that are not part of the regular Western diet should be described in more detail.',
        },
        'allergens': {
          'type': 'array',
          'items': {'type': 'string'},
          'description': 'The potential allergens in the menu item',
        },
        'isVegetarian': {
          'type': 'boolean',
          'description': 'True if the menu item is likely vegetarian',
        },
        'isVegan': {
          'type': 'boolean',
          'description': 'True if the menu item is likely vegan',
        },
      },
      'required': [
        'description',
        'allergens',
      ],
    };
    return jsonEncode(schema);
  }
}
