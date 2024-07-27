// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_item_chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ChatMessage {
  String get text => throw _privateConstructorUsedError;
  ChatParticipant get participant => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, ChatParticipant participant) user,
    required TResult Function(String text, ChatParticipant participant) bot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, ChatParticipant participant)? user,
    TResult? Function(String text, ChatParticipant participant)? bot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, ChatParticipant participant)? user,
    TResult Function(String text, ChatParticipant participant)? bot,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserMessage value) user,
    required TResult Function(BotMessage value) bot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserMessage value)? user,
    TResult? Function(BotMessage value)? bot,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserMessage value)? user,
    TResult Function(BotMessage value)? bot,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
          ChatMessage value, $Res Function(ChatMessage) then) =
      _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({String text, ChatParticipant participant});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? participant = null,
  }) {
    return _then(_value.copyWith(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      participant: null == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as ChatParticipant,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$UserMessageImplCopyWith(
          _$UserMessageImpl value, $Res Function(_$UserMessageImpl) then) =
      __$$UserMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, ChatParticipant participant});
}

/// @nodoc
class __$$UserMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$UserMessageImpl>
    implements _$$UserMessageImplCopyWith<$Res> {
  __$$UserMessageImplCopyWithImpl(
      _$UserMessageImpl _value, $Res Function(_$UserMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? participant = null,
  }) {
    return _then(_$UserMessageImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      participant: null == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as ChatParticipant,
    ));
  }
}

/// @nodoc

class _$UserMessageImpl implements UserMessage {
  const _$UserMessageImpl(
      {required this.text, this.participant = ChatParticipant.user});

  @override
  final String text;
  @override
  @JsonKey()
  final ChatParticipant participant;

  @override
  String toString() {
    return 'ChatMessage.user(text: $text, participant: $participant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserMessageImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.participant, participant) ||
                other.participant == participant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, participant);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserMessageImplCopyWith<_$UserMessageImpl> get copyWith =>
      __$$UserMessageImplCopyWithImpl<_$UserMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, ChatParticipant participant) user,
    required TResult Function(String text, ChatParticipant participant) bot,
  }) {
    return user(text, participant);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, ChatParticipant participant)? user,
    TResult? Function(String text, ChatParticipant participant)? bot,
  }) {
    return user?.call(text, participant);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, ChatParticipant participant)? user,
    TResult Function(String text, ChatParticipant participant)? bot,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(text, participant);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserMessage value) user,
    required TResult Function(BotMessage value) bot,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserMessage value)? user,
    TResult? Function(BotMessage value)? bot,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserMessage value)? user,
    TResult Function(BotMessage value)? bot,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class UserMessage implements ChatMessage {
  const factory UserMessage(
      {required final String text,
      final ChatParticipant participant}) = _$UserMessageImpl;

  @override
  String get text;
  @override
  ChatParticipant get participant;
  @override
  @JsonKey(ignore: true)
  _$$UserMessageImplCopyWith<_$UserMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BotMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$BotMessageImplCopyWith(
          _$BotMessageImpl value, $Res Function(_$BotMessageImpl) then) =
      __$$BotMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String text, ChatParticipant participant});
}

/// @nodoc
class __$$BotMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$BotMessageImpl>
    implements _$$BotMessageImplCopyWith<$Res> {
  __$$BotMessageImplCopyWithImpl(
      _$BotMessageImpl _value, $Res Function(_$BotMessageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
    Object? participant = null,
  }) {
    return _then(_$BotMessageImpl(
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      participant: null == participant
          ? _value.participant
          : participant // ignore: cast_nullable_to_non_nullable
              as ChatParticipant,
    ));
  }
}

/// @nodoc

class _$BotMessageImpl implements BotMessage {
  const _$BotMessageImpl(
      {required this.text, this.participant = ChatParticipant.bot});

  @override
  final String text;
  @override
  @JsonKey()
  final ChatParticipant participant;

  @override
  String toString() {
    return 'ChatMessage.bot(text: $text, participant: $participant)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BotMessageImpl &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.participant, participant) ||
                other.participant == participant));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text, participant);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BotMessageImplCopyWith<_$BotMessageImpl> get copyWith =>
      __$$BotMessageImplCopyWithImpl<_$BotMessageImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String text, ChatParticipant participant) user,
    required TResult Function(String text, ChatParticipant participant) bot,
  }) {
    return bot(text, participant);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String text, ChatParticipant participant)? user,
    TResult? Function(String text, ChatParticipant participant)? bot,
  }) {
    return bot?.call(text, participant);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String text, ChatParticipant participant)? user,
    TResult Function(String text, ChatParticipant participant)? bot,
    required TResult orElse(),
  }) {
    if (bot != null) {
      return bot(text, participant);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserMessage value) user,
    required TResult Function(BotMessage value) bot,
  }) {
    return bot(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserMessage value)? user,
    TResult? Function(BotMessage value)? bot,
  }) {
    return bot?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserMessage value)? user,
    TResult Function(BotMessage value)? bot,
    required TResult orElse(),
  }) {
    if (bot != null) {
      return bot(this);
    }
    return orElse();
  }
}

abstract class BotMessage implements ChatMessage {
  const factory BotMessage(
      {required final String text,
      final ChatParticipant participant}) = _$BotMessageImpl;

  @override
  String get text;
  @override
  ChatParticipant get participant;
  @override
  @JsonKey(ignore: true)
  _$$BotMessageImplCopyWith<_$BotMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MenuItemChat {
  ProcessedMenuItem get menuItem => throw _privateConstructorUsedError;
  List<ChatMessage> get messages => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MenuItemChatCopyWith<MenuItemChat> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MenuItemChatCopyWith<$Res> {
  factory $MenuItemChatCopyWith(
          MenuItemChat value, $Res Function(MenuItemChat) then) =
      _$MenuItemChatCopyWithImpl<$Res, MenuItemChat>;
  @useResult
  $Res call({ProcessedMenuItem menuItem, List<ChatMessage> messages});
}

/// @nodoc
class _$MenuItemChatCopyWithImpl<$Res, $Val extends MenuItemChat>
    implements $MenuItemChatCopyWith<$Res> {
  _$MenuItemChatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = freezed,
    Object? messages = null,
  }) {
    return _then(_value.copyWith(
      menuItem: freezed == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as ProcessedMenuItem,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MenuItemChatImplCopyWith<$Res>
    implements $MenuItemChatCopyWith<$Res> {
  factory _$$MenuItemChatImplCopyWith(
          _$MenuItemChatImpl value, $Res Function(_$MenuItemChatImpl) then) =
      __$$MenuItemChatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ProcessedMenuItem menuItem, List<ChatMessage> messages});
}

/// @nodoc
class __$$MenuItemChatImplCopyWithImpl<$Res>
    extends _$MenuItemChatCopyWithImpl<$Res, _$MenuItemChatImpl>
    implements _$$MenuItemChatImplCopyWith<$Res> {
  __$$MenuItemChatImplCopyWithImpl(
      _$MenuItemChatImpl _value, $Res Function(_$MenuItemChatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? menuItem = freezed,
    Object? messages = null,
  }) {
    return _then(_$MenuItemChatImpl(
      menuItem: freezed == menuItem
          ? _value.menuItem
          : menuItem // ignore: cast_nullable_to_non_nullable
              as ProcessedMenuItem,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<ChatMessage>,
    ));
  }
}

/// @nodoc

class _$MenuItemChatImpl extends _MenuItemChat {
  const _$MenuItemChatImpl({required this.menuItem, required this.messages})
      : super._();

  @override
  final ProcessedMenuItem menuItem;
  @override
  final List<ChatMessage> messages;

  @override
  String toString() {
    return 'MenuItemChat(menuItem: $menuItem, messages: $messages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MenuItemChatImpl &&
            const DeepCollectionEquality().equals(other.menuItem, menuItem) &&
            const DeepCollectionEquality().equals(other.messages, messages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(menuItem),
      const DeepCollectionEquality().hash(messages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MenuItemChatImplCopyWith<_$MenuItemChatImpl> get copyWith =>
      __$$MenuItemChatImplCopyWithImpl<_$MenuItemChatImpl>(this, _$identity);
}

abstract class _MenuItemChat extends MenuItemChat {
  const factory _MenuItemChat(
      {required final ProcessedMenuItem menuItem,
      required final List<ChatMessage> messages}) = _$MenuItemChatImpl;
  const _MenuItemChat._() : super._();

  @override
  ProcessedMenuItem get menuItem;
  @override
  List<ChatMessage> get messages;
  @override
  @JsonKey(ignore: true)
  _$$MenuItemChatImplCopyWith<_$MenuItemChatImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
