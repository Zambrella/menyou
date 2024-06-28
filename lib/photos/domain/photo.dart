import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo.freezed.dart';

@freezed
class Photo with _$Photo {
  const factory Photo({
    required String photoName,
    required Uint8List photoData,
    @Default('image/png') String mimeType,
  }) = _Photo;
}
