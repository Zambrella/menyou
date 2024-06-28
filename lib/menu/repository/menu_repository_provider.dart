import 'package:men_you/app_dependencies.dart';
import 'package:men_you/menu/domain/menu_repository.abs.dart';
import 'package:men_you/menu/repository/firebase_menu_repository.impl.dart';
import 'package:men_you/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_repository_provider.g.dart';

@Riverpod(keepAlive: true)
MenuRepository menuRepository(MenuRepositoryRef ref) {
  return FirebaseMenuRepository(
    ref.watch(aiModelProvider),
    ref.watch(firestoreProvider),
    ref.watch(firebaseAuthProvider),
    ref.watch(loggerProvider),
  );
}
