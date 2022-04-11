import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo2/pages/utils/throttle_droppable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episodes_bloc.g.dart';
part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends HydratedBloc<EpisodesEvent, EpisodesState>
    with ThrottleDroppable {
  EpisodesBloc(EntitiesRepository entitiesRepository)
      : _apiEpisode = entitiesRepository.apiEpisode,
        super(EpisodesInitial()) {
    on<EpisodesReset>(
      (event, emit) {
        add(const EpisodesFetchNextPage(reset: true));
      },
    );

    on<EpisodesFetchFirstPage>(
      (event, emit) {
        if (state.episodes.isEmpty) {
          add(const EpisodesFetchNextPage());
        }
      },
    );

    on<EpisodesFetchNextPage>(
      _fetchNextPage,
      transformer: throttleDroppable(),
    );
  }

  @override
  EpisodesState? fromJson(Map<String, dynamic> json) =>
      EpisodesState.fromJson(json);

  @override
  Map<String, dynamic> toJson(EpisodesState state) => state.toJson();

  final ApiEpisode _apiEpisode;

  Future<void> _fetchNextPage(
    EpisodesFetchNextPage event,
    Emitter<EpisodesState> emit,
  ) async {
    try {
      if (state.fetchedAll && !event.reset) {
        return;
      }
      emit(
        state.copyWith(
          status: EpisodesStatus.loading,
        ),
      );
      if (event.reset) {
        final page = await _apiEpisode.getAllEpisodes();
        emit(
          state.copyWith(
            status: EpisodesStatus.success,
            episodes: page.entities,
            lastPage: page,
          ),
        );
      } else {
        final page = await _apiEpisode.getAllEpisodes(prevPage: state.lastPage);
        emit(
          state.copyWith(
            status: EpisodesStatus.success,
            episodes: [...state.episodes, ...page.entities],
            lastPage: page,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: EpisodesStatus.failure));
    }
  }
}
