import 'package:animated_list_plus/transitions.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
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
  ConsumerState<ConsumerStatefulWidget> createState() => MenuItemChatPageState();
}

class MenuItemChatPageState extends ConsumerState<MenuItemChatPage> {
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
    ref.listen(
      menuItemChatControllerProvider(widget.menuItem),
      (prev, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error, _) {
            toastification.showError(context: context, message: error.toString());
          },
        );
      },
    );

    final menuItemChatController = ref.watch<AsyncValue<MenuItemChat>>(menuItemChatControllerProvider(widget.menuItem));
    // Initial value should be AsyncData with empty messages
    final messages = menuItemChatController.requireValue.messages;

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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: messages.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.question_answer_outlined,
                              size: 36,
                              color: context.theme.colorScheme.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Ask me something about ${widget.menuItem.title}',
                              style: context.theme.textTheme.bodyLarge?.copyWith(color: context.theme.colorScheme.onSurface),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : AnimatedChatList(
                        messages: messages,
                        scrollController: _scrollController,
                      ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              height: menuItemChatController.isLoading ? 48 : 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...Iterable.generate(
                    3,
                    (index) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.theme.colorScheme.primary.withOpacity(0.5),
                      ),
                    ),
                  )
                      .toList()
                      .animate(
                        interval: 400.ms,
                        onPlay: (controller) => controller.repeat(reverse: true),
                      )
                      .fade(
                        duration: 1200.ms,
                        begin: 0.2,
                        end: 1,
                      )
                      .moveY(
                        begin: -2,
                        end: 2,
                        duration: 1200.ms,
                      ),
                  const SizedBox(width: 8),
                  Text(
                    'Bot is typing...',
                    style: context.theme.textTheme.bodyLarge?.copyWith(color: context.theme.colorScheme.onSurface),
                  ),
                ],
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
                          hintText: 'Ask a question',
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

class AnimatedChatList extends StatefulWidget {
  const AnimatedChatList({required this.messages, required this.scrollController, super.key});

  final List<ChatMessage> messages;
  final ScrollController scrollController;

  @override
  State<AnimatedChatList> createState() => _AnimatedChatListState();
}

class _AnimatedChatListState extends State<AnimatedChatList> {
  List<ChatMessage> get messages => widget.messages;
  static const double _largeChatBubblePadding = 52;

  late int initialCount;

  @override
  void initState() {
    super.initState();
    initialCount = messages.length;
  }

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  void didUpdateWidget(covariant AnimatedChatList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.messages.length < messages.length) {
      _listKey.currentState?.insertItem(0, duration: const Duration(milliseconds: 500));
    }
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    return AnimatedList(
      key: _listKey,
      controller: widget.scrollController,
      reverse: true,
      initialItemCount: initialCount,
      itemBuilder: (context, index, animation) {
        index = (index + 1 - messages.length).abs();
        final message = messages[index];
        return SizeFadeTransition(
          key: ValueKey(message),
          sizeFraction: 0.7,
          curve: Curves.easeIn,
          animation: animation,
          child: switch (message.participant) {
            ChatParticipant.user => Padding(
                padding: EdgeInsets.only(
                  left: textDirection == TextDirection.ltr ? _largeChatBubblePadding : 8,
                  top: 8,
                  right: textDirection == TextDirection.ltr ? 8 : _largeChatBubblePadding,
                  bottom: 16,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message.text,
                        textAlign: TextAlign.end,
                        style: context.theme.textTheme.bodyLarge?.copyWith(
                          color: context.theme.colorScheme.onSurface,
                          height: 1.3,
                        ),
                      ),
                      Text(
                        'You',
                        textAlign: TextAlign.end,
                        style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
            ChatParticipant.bot => Padding(
                padding: EdgeInsets.only(
                  left: textDirection == TextDirection.ltr ? 8 : _largeChatBubblePadding,
                  top: 8,
                  right: textDirection == TextDirection.ltr ? _largeChatBubblePadding : 8,
                  bottom: 8,
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.theme.colorScheme.surfaceContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Markdown(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        data: message.text,
                        padding: const EdgeInsets.all(8),
                        selectable: true,
                        styleSheet: MarkdownStyleSheet(
                          p: context.theme.textTheme.bodyLarge?.copyWith(
                            color: context.theme.colorScheme.onSurface,
                            height: 1.3,
                          ),
                          listBullet: context.theme.textTheme.bodyLarge?.copyWith(color: context.theme.colorScheme.onSurface),
                        ),
                      ),
                      Text(
                        'Bot',
                        textAlign: TextAlign.start,
                        style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ),
          },
        );
      },
    );
  }
}
