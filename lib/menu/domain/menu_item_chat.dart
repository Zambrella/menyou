import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:men_you/menu/domain/menu_item.dart';

part 'menu_item_chat.freezed.dart';

enum ChatParticipant {
  user,
  bot,
}

@freezed
sealed class ChatMessage with _$ChatMessage {
  const factory ChatMessage.user({
    required String text,
    @Default(ChatParticipant.user) ChatParticipant participant,
  }) = UserMessage;

  const factory ChatMessage.bot({
    required String text,
    @Default(ChatParticipant.bot) ChatParticipant participant,
  }) = BotMessage;
}

@Freezed(makeCollectionsUnmodifiable: false)
class MenuItemChat with _$MenuItemChat {
  const factory MenuItemChat({
    required ProcessedMenuItem menuItem,
    required List<ChatMessage> messages,
  }) = _MenuItemChat;

  const MenuItemChat._();

  /// Returns a new [MenuItemChat] with the given [messages] added to the existing ones.
  MenuItemChat addMessage(ChatMessage message) {
    return copyWith(
      messages: List<ChatMessage>.from([...messages, message]),
    );
  }
}
