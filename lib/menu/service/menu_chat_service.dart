import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:logger/logger.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/repository/firebase_menu_repository.impl.dart';

class MenuChatService {
  MenuChatService(this._menuRepository, this._logger);

  final FirebaseMenuRepository _menuRepository;
  final Logger _logger;

  /// The chat sessions for each menu item.
  /// State is kept in memory for simplicity but could be persisted to a database.
  final Map<String, ChatSession> _sessions = {};

  /// Starts a chat with the bot.
  /// This seeds it with the given [menuItem] and [message].
  Future<String> startMenuItemChat(MenuItem menuItem, String message) async {
    final session = await _menuRepository.startChat();
    _sessions[menuItem.id] = session;
    final initialMessage = Content.text('''
You are an expert about restaurant food. Answer questions about the following menu item:
## Menu Item
- Title: ${menuItem.title}
- Subtitle: ${menuItem.subtitle}

## Question
$message
''');
    final response = await session.sendMessage(initialMessage);
    final responseText = response.text;
    _logger.d('Response text: $responseText');
    if (responseText == null) {
      throw Exception('No text found in the response');
    }
    return responseText;
  }

  /// Sends a message to the bot and returns the response.
  /// Will start a new chat session if one does not already exist.
  /// Otherwise, it will continue the existing chat session.
  Future<String> sendMessage(MenuItem menuItem, String message) async {
    if (_sessions[menuItem.id] == null) {
      _logger.d('Starting a new chat session');
      return startMenuItemChat(menuItem, message);
    }

    final session = _sessions[menuItem.id]!;
    _logger.d('Continuing the chat session');
    final result = await session.sendMessage(Content.text(message));
    final responseText = result.text;
    if (responseText == null) {
      throw Exception('No text found in the response');
    }
    _logger.d('Response text: $responseText');
    return responseText;
  }
}
