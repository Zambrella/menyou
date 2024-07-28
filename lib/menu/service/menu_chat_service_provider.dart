import 'package:men_you/app_dependencies.dart';
import 'package:men_you/menu/repository/firebase_menu_repository.impl.dart';
import 'package:men_you/menu/repository/menu_repository_provider.dart';
import 'package:men_you/menu/service/menu_chat_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_chat_service_provider.g.dart';

@Riverpod(keepAlive: true)
MenuChatService menuChatService(MenuChatServiceRef ref) {
  return MenuChatService(
    ref.watch(menuRepositoryProvider) as FirebaseMenuRepository,
    ref.watch(loggerProvider),
  );
}
