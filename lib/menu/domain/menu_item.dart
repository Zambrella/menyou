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
  }) = ProcessedMenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
}
