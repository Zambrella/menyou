import 'package:men_you/menu/domain/menu_repository.abs.dart';
import 'package:men_you/menu/repository/fake_menu_repository.impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_repository_provider.g.dart';

@riverpod
MenuRepository menuRepository(MenuRepositoryRef ref) {
  return const FakeMenuRepository();
}
