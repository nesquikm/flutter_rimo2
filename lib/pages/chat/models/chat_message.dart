import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

enum ChatMessageAuthor {
  @JsonValue('Human')
  human,
  @JsonValue('Bot')
  bot,
}

@JsonSerializable()
class ChatMessage extends Equatable {
  const ChatMessage({
    required this.author,
    required this.text,
    this.imageUrl,
    this.characterId,
    this.episodeId,
  });

  /// Create chat message from json
  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageFromJson(json);

  /// Store chat message to json
  Map<String, dynamic> toJson() => _$ChatMessageToJson(this);

  final ChatMessageAuthor author;
  final String text;
  final String? imageUrl;
  final int? characterId;
  final int? episodeId;

  @override
  List<Object?> get props => [author, text, imageUrl, characterId, episodeId];
}
