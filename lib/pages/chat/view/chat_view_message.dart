import 'package:flutter/material.dart';
import 'package:flutter_rimo2/pages/chat/models/chat_message.dart';
import 'package:flutter_rimo2/pages/pages.dart';
import 'package:go_router/go_router.dart';

class ChatViewMessage extends StatelessWidget {
  const ChatViewMessage({super.key, required this.chatMessage});

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      if (chatMessage.characterId != null) {
        context.goNamed(
          InfoPageName.character.name,
          params: {
            'page': HomePageName.chat.name,
            'id': '${chatMessage.characterId}'
          },
        );
      } else if (chatMessage.episodeId != null) {
        context.goNamed(
          InfoPageName.episode.name,
          params: {
            'page': HomePageName.chat.name,
            'id': '${chatMessage.episodeId}'
          },
        );
      }
    }

    final avatar = Icon(
      chatMessage.author == ChatMessageAuthor.bot ? Icons.android : Icons.face,
    );
    return Row(
      mainAxisAlignment: (chatMessage.author == ChatMessageAuthor.bot)
          ? MainAxisAlignment.start
          : MainAxisAlignment.end,
      children: [
        if (chatMessage.author == ChatMessageAuthor.bot)
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 8),
            child: avatar,
          )
        else
          const SizedBox(width: 32),
        Expanded(
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.all(8),
            child: InkWell(
              onTap: _onTap,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chatMessage.text),
                    if (chatMessage.imageUrl != null) ...[
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 256,
                            maxWidth: 256,
                          ),
                          child: Image.network(
                            chatMessage.imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
        if (chatMessage.author == ChatMessageAuthor.human)
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 16),
            child: avatar,
          )
        else
          const SizedBox(width: 32),
      ],
    );
  }
}
