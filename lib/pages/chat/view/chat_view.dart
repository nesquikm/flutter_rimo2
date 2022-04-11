import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/chat/bloc/chat_bloc.dart';
import 'package:flutter_rimo2/pages/chat/view/chat_view_message.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final TextEditingController textEditingController;

  late final Random _random;

  late final ScrollController _listScrollController;

  @override
  void initState() {
    super.initState();

    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    _random = Random();
  }

  Future<void> _onSend({
    required BuildContext context,
    required String text,
  }) async {
    if (text.trim().isNotEmpty) {
      context.read<ChatBloc>().add(ChatSendTextQuery(query: text));
      textEditingController.clear();
      await _listScrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Widget buildInput({required BuildContext context}) {
    return SizedBox(
      width: double.infinity,
      height: 64,
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.all(16),
              child: TextField(
                onSubmitted: (value) {
                  _onSend(context: context, text: textEditingController.text);
                },
                controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: hints[_random.nextInt(hints.length)],
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: IconButton(
              icon: const Icon(Icons.send),
              onPressed: () =>
                  _onSend(context: context, text: textEditingController.text),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.appBarTitleChat)),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ChatBloc, ChatState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == ChatStatus.failure) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(l10n.chatErrorSnackbarText),
                      ),
                    );
                }
              },
            ),
          ],
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          reverse: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.messages.length,
                          itemBuilder: (BuildContext context, int index) {
                            final resversedIndex =
                                state.messages.length - index - 1;
                            final chatMessage = state.messages[resversedIndex];
                            return ChatViewMessage(chatMessage: chatMessage);
                          },
                          controller: _listScrollController,
                        ),
                      ),
                      buildInput(context: context),
                    ],
                  ),
                  Center(
                    child: (state.status == ChatStatus.failure)
                        ? Text(l10n.chatErrorSnackbarText)
                        : null,
                  ),
                  Center(
                    child: (state.status == ChatStatus.initial ||
                            state.messages.isEmpty)
                        ? const Icon(Icons.waving_hand, size: 32)
                        : null,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

const hints = [
  'Tell me about Rick Sanchez',
  'What do you know about Rick Sanchez?',
  'Have you heard anything about Rick Sanchez?',
  'Do you remember Rick Sanchez?',
  'Who is Rick Sanchez?',
  'What happened in Lawnmower Dog?',
  'What happened in Pilot?',
];
