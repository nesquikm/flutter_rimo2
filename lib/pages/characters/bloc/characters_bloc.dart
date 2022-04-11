import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo2/pages/utils/throttle_droppable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'characters_bloc.g.dart';
part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends HydratedBloc<CharactersEvent, CharactersState>
    with ThrottleDroppable {
  CharactersBloc(EntitiesRepository entitiesRepository)
      : _apiCharacter = entitiesRepository.apiCharacter,
        super(CharactersInitial()) {
    on<CharactersReset>(
      (event, emit) {
        add(const CharactersFetchNextPage(reset: true));
      },
    );

    on<CharactersFetchFirstPage>(
      (event, emit) {
        if (state.characters.isEmpty) {
          add(const CharactersFetchNextPage());
        }
      },
    );

    on<CharactersFetchNextPage>(
      _fetchNextPage,
      transformer: throttleDroppable(),
    );
  }

  @override
  CharactersState? fromJson(Map<String, dynamic> json) =>
      CharactersState.fromJson(json);

  @override
  Map<String, dynamic> toJson(CharactersState state) => state.toJson();

  final ApiCharacter _apiCharacter;

  Future<void> _fetchNextPage(
    CharactersFetchNextPage event,
    Emitter<CharactersState> emit,
  ) async {
    try {
      if (state.fetchedAll && !event.reset) {
        return;
      }
      emit(
        state.copyWith(
          status: CharactersStatus.loading,
        ),
      );
      if (event.reset) {
        final page = await _apiCharacter.getAllCharacters();
        emit(
          state.copyWith(
            status: CharactersStatus.success,
            characters: page.entities,
            lastPage: page,
          ),
        );
      } else {
        final page =
            await _apiCharacter.getAllCharacters(prevPage: state.lastPage);
        emit(
          state.copyWith(
            status: CharactersStatus.success,
            characters: [...state.characters, ...page.entities],
            lastPage: page,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: CharactersStatus.failure));
    }
  }
}
