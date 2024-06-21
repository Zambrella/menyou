import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/repository/menu_repository_provider.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_analyser_controller.g.dart';

@riverpod
FutureOr<List<MenuItem>> photoAnalyserController(PhotoAnalyserControllerRef ref, Photo photo) async {
  return ref.read(menuRepositoryProvider).analysePhoto(photo.photoData);
}
