import 'package:image_picker/image_picker.dart';
import 'package:men_you/app_dependencies.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_photo_controller.g.dart';

@riverpod
class GetPhotoController extends _$GetPhotoController {
  @override
  FutureOr<Photo?> build() async {
    return null;
  }

  /// Get a photo from the camera or gallery.
  Future<void> getPhoto(ImageSource imageSource) async {
    state = const AsyncLoading();
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: imageSource);
      if (file == null) {
        ref.read(loggerProvider).d('No photo taken');
        state = const AsyncData(null);
        return;
      } else {
        final photoData = await file.readAsBytes();
        final photo = Photo(
          photoData: photoData,
          photoName: file.name,
          mimeType: file.mimeType ?? 'image/png',
        );
        ref.read(loggerProvider).d('Photo generated: $photo');
        state = AsyncData(photo);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
