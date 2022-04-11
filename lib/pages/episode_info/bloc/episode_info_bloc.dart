import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo2/pages/utils/throttle_droppable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'episode_info_bloc.g.dart';
part 'episode_info_event.dart';
part 'episode_info_state.dart';

class EpisodeInfoBloc extends HydratedBloc<EpisodeInfoEvent, EpisodeInfoState>
    with ThrottleDroppable {
  EpisodeInfoBloc(EntitiesRepository entitiesRepository)
      : _apiEpisode = entitiesRepository.apiEpisode,
        super(EpisodeInfoInitial()) {
    on<EpisodeInfoRefresh>(
      (event, emit) {
        if (state.episode != null) {
          add(EpisodeInfoFetchById(id: state.episode!.id, refresh: true));
        }
      },
    );

    on<EpisodeInfoFetchById>(
      _fetchById,
      transformer: throttleDroppable(),
    );
  }

  @override
  EpisodeInfoState? fromJson(Map<String, dynamic> json) =>
      EpisodeInfoState.fromJson(json);

  @override
  Map<String, dynamic> toJson(EpisodeInfoState state) => state.toJson();

  final ApiEpisode _apiEpisode;

  Future<void> _fetchById(
    EpisodeInfoFetchById event,
    Emitter<EpisodeInfoState> emit,
  ) async {
    try {
      final id = event.id;
      final episode = state.episodeCache[id];
      if (episode != null && !event.refresh) {
        emit(
          state.copyWith(
            status: EpisodeInfoStatus.success,
            episode: episode,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: EpisodeInfoStatus.loading,
            episode: episode,
            forceSetEpisode: true,
          ),
        );
        final episodes = await _apiEpisode.getListOfEpisodes(ids: [id]);
        if (episodes.isEmpty) {
          throw Exception('EpisodeInfo with id $id not found');
        }
        emit(
          state.copyWith(
            status: EpisodeInfoStatus.success,
            episodeCache: {
              ...state.episodeCache,
              ...{id: episodes[0]}
            },
            episode: episodes[0],
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: EpisodeInfoStatus.failure));
    }
  }
}
