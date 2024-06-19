import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item.g.dart';
part 'menu_item.freezed.dart';

@freezed
class MenuItem with _$MenuItem {
  const factory MenuItem.unprocessed({
    required String id,
    required String title,
    required String description,
  }) = UnprocessedMenuItem;

  const factory MenuItem.processed({
    required String id,
    required String title,
    required String description,
  }) = ProcessedMenuItem;

  factory MenuItem.fromJson(Map<String, dynamic> json) => _$MenuItemFromJson(json);
}
