import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/photos/domain/photo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'photo_analyser_controller.g.dart';

@riverpod
FutureOr<List<MenuItem>> photoAnalyserController(PhotoAnalyserControllerRef ref, Photo photo) async {
  await Future<void>.delayed(const Duration(seconds: 3));
  return const [
    MenuItem.unprocessed(
      id: '1',
      title: 'Spaghetti Carbonara',
      description: 'Spaghetti with bacon, eggs, and cheese',
    ),
    MenuItem.unprocessed(
      id: '2',
      title: 'Spaghetti Bolognese',
      description: 'Spaghetti with meat sauce',
    ),
    MenuItem.unprocessed(
      id: '3',
      title: 'Spaghetti Aglio e Olio',
      description: 'Spaghetti with garlic and olive oil',
    ),
  ];
}
