part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatSendTextQuery extends ChatEvent {
  const ChatSendTextQuery({required this.query});

  final String query;

  @override
  List<Object> get props => [query];
}
