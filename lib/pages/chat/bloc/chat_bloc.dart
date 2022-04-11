import 'package:df_repository/df_repository.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo2/pages/chat/models/models.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_bloc.g.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends HydratedBloc<ChatEvent, ChatState> {
  ChatBloc(EntitiesRepository entitiesRepository, DfRepository dfRepository)
      : _apiCharacter = entitiesRepository.apiCharacter,
        _apiEpisode = entitiesRepository.apiEpisode,
        _dfApi = dfRepository.dfApi,
        super(ChatInitial()) {
    _dfApi.init();
    on<ChatSendTextQuery>(_sendTextQuery);
  }

  @override
  ChatState? fromJson(Map<String, dynamic> json) => ChatState.fromJson(json);

  @override
  Map<String, dynamic> toJson(ChatState state) => state.toJson();

  final ApiCharacter _apiCharacter;
  final ApiEpisode _apiEpisode;
  final DfApi _dfApi;

  Future<void> _processCharacterSearch({
    required DfApiTextResponse response,
    required Emitter<ChatState> emit,
  }) async {
    final characterName = response.parameters!['character'];
    if (characterName != null) {
      final pageCharacter = await _apiCharacter.getAllCharacters(
        filters: ApiCharacterFilters(name: characterName),
      );
      final character = pageCharacter.entities
          .firstWhere((character) => character.name == characterName);

      final responseChatMessageExtended = ChatMessage(
        author: ChatMessageAuthor.bot,
        text:
            // ignore: lines_longer_than_80_chars
            '${character.name}: ${character.gender.name}, ${character.species}',
        imageUrl: character.image,
        characterId: character.id,
      );
      emit(
        state.copyWith(
          status: ChatStatus.success,
          messages: [...state.messages, responseChatMessageExtended],
        ),
      );
    }
  }

  Future<void> _processEpisodeSearch({
    required DfApiTextResponse response,
    required Emitter<ChatState> emit,
  }) async {
    final episodeName = response.parameters!['Episode'];
    if (episodeName != null) {
      final pageEpisode = await _apiEpisode.getAllEpisodes(
        filters: ApiEpisodeFilters(name: episodeName),
      );
      final episode = pageEpisode.entities
          .firstWhere((character) => character.name == episodeName);

      final responseChatMessageExtended = ChatMessage(
        author: ChatMessageAuthor.bot,
        text: 'Episode "${episode.name}" was aired ${episode.airDate}',
        episodeId: episode.id,
      );
      emit(
        state.copyWith(
          status: ChatStatus.success,
          messages: [...state.messages, responseChatMessageExtended],
        ),
      );
    }
  }

  Future<void> _sendTextQuery(
    ChatSendTextQuery event,
    Emitter<ChatState> emit,
  ) async {
    try {
      final queryChatMessage =
          ChatMessage(author: ChatMessageAuthor.human, text: event.query);
      emit(
        state.copyWith(
          status: ChatStatus.loading,
          messages: [...state.messages, queryChatMessage],
        ),
      );
      final response = await _dfApi.textQuery(query: event.query);
      final responseChatMessage =
          ChatMessage(author: ChatMessageAuthor.bot, text: response.text);
      emit(
        state.copyWith(
          status: ChatStatus.success,
          messages: [...state.messages, responseChatMessage],
        ),
      );
      if (response.parameters != null && response.parameters!.isNotEmpty) {
        switch (response.intentName?.toLowerCase()) {
          case 'character search':
            await _processCharacterSearch(response: response, emit: emit);
            break;
          case 'episode search':
            await _processEpisodeSearch(response: response, emit: emit);
            break;
        }
      }
    } catch (_) {
      emit(state.copyWith(status: ChatStatus.failure));
    }
  }
}
