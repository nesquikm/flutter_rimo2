import 'package:flutter/material.dart';
// import 'package:flutter_rimo2/pages/character_info/view/view.dart';
import 'package:flutter_rimo2/pages/chat/models/chat_message.dart';
// import 'package:flutter_rimo2/pages/episode_info/view/view.dart';

class ChatViewMessage extends StatelessWidget {
  const ChatViewMessage({Key? key, required this.chatMessage})
      : super(key: key);

  final ChatMessage chatMessage;

  @override
  Widget build(BuildContext context) {
    void _onTap() {
      if (chatMessage.characterId != null) {
        // TODO(nesquikm): Navigate!
        // Navigator.of(context).push(
        //   CharacterInfoPage.route(
        //     id: chatMessage.characterId!,
        //   ),
        // );
      } else if (chatMessage.episodeId != null) {
        // TODO(nesquikm): Navigate!
        // Navigator.of(context).push(
        //   EpisodeInfoPage.route(
        //     id: chatMessage.episodeId!,
        //   ),
        // );
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
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(128),
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
