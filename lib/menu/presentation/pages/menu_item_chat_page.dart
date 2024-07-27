import 'dart:math';

import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:men_you/common/extensions/toastification_extensions.dart';
import 'package:men_you/menu/domain/menu_item.dart';
import 'package:men_you/menu/domain/menu_item_chat.dart';
import 'package:men_you/menu/presentation/controllers/menu_item_chat_controller.dart';
import 'package:men_you/theme/theme_extensions.dart';
import 'package:toastification/toastification.dart';

class MenuItemChatPage extends ConsumerStatefulWidget {
  const MenuItemChatPage({
    required this.menuItem,
    super.key,
  });

  final ProcessedMenuItem menuItem;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MenuItemChatPageState();
}

class _MenuItemChatPageState extends ConsumerState<MenuItemChatPage> {
  late final TextEditingController _textController = TextEditingController();
  late final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _textController.text;
    if (text.isEmpty) {
      return;
    }
    _textController.clear();
    await ref.read(menuItemChatControllerProvider(widget.menuItem).notifier).sendMessage(text);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(menuItemChatControllerProvider(widget.menuItem), (_, state) {
      if (state is AsyncError) {
        toastification.showError(context: context, message: state.error.toString());
      }
    });

    final menuItemChatController = ref.watch<AsyncValue<MenuItemChat>>(menuItemChatControllerProvider(widget.menuItem));
    // Initial value should be AsyncData with empty messages
    final messages = menuItemChatController.requireValue.messages;

    final keyboardHeight = MediaQuery.of(Scaffold.of(context).context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.menuItem.title),
      ),
      body: ColorfulSafeArea(
        top: false,
        right: false,
        left: false,
        color: context.theme.colorScheme.surfaceContainer,
        child: Column(
          children: [
            Expanded(
              child: Builder(
                builder: (context) {
                  if (messages.isEmpty) {
                    return Center(
                      child: Text(
                        'Ask me something about ${widget.menuItem.title}',
                        style: context.theme.textTheme.bodyLarge?.copyWith(color: context.theme.colorScheme.onSurface),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: max(keyboardHeight - 18, 0)),
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        index = (index + 1 - messages.length).abs();
                        final message = messages[index];
                        switch (message.participant) {
                          case ChatParticipant.user:
                            return ListTile(
                              title: Text(
                                message.text,
                                textAlign: TextAlign.end,
                              ),
                              subtitle: const Text(
                                'You',
                                textAlign: TextAlign.end,
                              ),
                            );
                          case ChatParticipant.bot:
                            return ListTile(
                              title: Text(
                                message.text,
                                style: TextStyle(fontSize: 20),
                              ),
                              subtitle: const Text(
                                'Bot',
                              ),
                            );
                        }
                      },
                    );
                  }
                },
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              height: menuItemChatController.isLoading ? 48 : 0,
              child: Text(
                'Bot is typing...',
                style: context.theme.textTheme.bodyLarge?.copyWith(color: context.theme.colorScheme.onSurface),
              ),
            ),
            ColoredBox(
              color: context.theme.colorScheme.surfaceContainer,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: context.theme.colorScheme.onSurface),
                        autofocus: true,
                        controller: _textController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.send,
                        textCapitalization: TextCapitalization.sentences,
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                          hintText: 'Type a message',
                          hintStyle: TextStyle(color: context.theme.colorScheme.onSurfaceVariant),
                        ),
                        onSubmitted: (_) {
                          _sendMessage();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: _sendMessage,
                      icon: ValueListenableBuilder(
                        valueListenable: _textController,
                        builder: (context, textValue, _) {
                          return Icon(
                            Icons.send,
                            color: textValue.text.isEmpty ? context.theme.colorScheme.onSurfaceVariant : context.theme.colorScheme.primary,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
