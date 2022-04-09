import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stream_transform/stream_transform.dart';

part 'character_info_bloc.g.dart';
part 'character_info_event.dart';
part 'character_info_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class CharacterInfoBloc
    extends HydratedBloc<CharacterInfoEvent, CharacterInfoState> {
  CharacterInfoBloc(EntitiesRepository entitiesRepository)
      : _apiCharacter = entitiesRepository.apiCharacter,
        super(CharacterInfoInitial()) {
    on<CharacterInfoRefresh>(
      (event, emit) {
        if (state.character != null) {
          add(CharacterInfoFetchById(id: state.character!.id, refresh: true));
        }
      },
    );

    on<CharacterInfoFetchById>(
      _fetchById,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  @override
  CharacterInfoState? fromJson(Map<String, dynamic> json) =>
      CharacterInfoState.fromJson(json);

  @override
  Map<String, dynamic> toJson(CharacterInfoState state) => state.toJson();

  final ApiCharacter _apiCharacter;

  Future<void> _fetchById(
    CharacterInfoFetchById event,
    Emitter<CharacterInfoState> emit,
  ) async {
    try {
      final id = event.id;
      final character = state.characterCache[id];
      if (character != null && !event.refresh) {
        emit(
          state.copyWith(
            status: CharacterInfoStatus.success,
            character: character,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: CharacterInfoStatus.loading,
            character: character,
            forceSetCharacter: true,
          ),
        );
        final characters = await _apiCharacter.getListOfCharacters(ids: [id]);
        if (characters.isEmpty) {
          throw Exception('CharacterInfo with id $id not found');
        }
        emit(
          state.copyWith(
            status: CharacterInfoStatus.success,
            characterCache: {
              ...state.characterCache,
              ...{id: characters[0]}
            },
            character: characters[0],
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: CharacterInfoStatus.failure));
    }
  }
}
