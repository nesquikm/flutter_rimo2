part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, success, failure }

@JsonSerializable()
class ChatState extends Equatable {
  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
  });

  @override
  factory ChatState.fromJson(Map<String, dynamic> json) =>
      _$ChatStateFromJson(json);

  Map<String, dynamic> toJson() => _$ChatStateToJson(this);

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessage>? messages,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
    );
  }

  final ChatStatus? status;
  final List<ChatMessage> messages;

  @override
  List<Object?> get props => [status, messages];
}

class ChatInitial extends ChatState {}
