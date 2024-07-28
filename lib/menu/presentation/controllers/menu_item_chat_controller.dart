import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/domain/menu_item_chat.dart';
import 'package:men_you/menu/service/menu_chat_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'menu_item_chat_controller.g.dart';

@Riverpod(keepAlive: true)
class MenuItemChatController extends _$MenuItemChatController {
  @override
  FutureOr<MenuItemChat> build(MenuItem menuItem) {
    if (menuItem is! ProcessedMenuItem) {
      throw ArgumentError('Expected a ProcessedMenuItem, got $menuItem');
    }
    return MenuItemChat(menuItem: menuItem, messages: []);
  }

  Future<void> sendMessage(String text) async {
    try {
      // Update UI straight away
      final updatedState = state.requireValue.addMessage(ChatMessage.user(text: text));
      state = AsyncData(updatedState);
      await Future<void>.delayed(const Duration(milliseconds: 50));

      // Mark the bot as typing
      state = const AsyncLoading();

      // Send the message
      final result = await ref.read(menuChatServiceProvider).sendMessage(state.requireValue.menuItem, text);

      // Update the UI with the result
      state = AsyncData(state.requireValue.addMessage(ChatMessage.bot(text: result)));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
