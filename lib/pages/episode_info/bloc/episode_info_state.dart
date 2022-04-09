part of 'episode_info_bloc.dart';

enum EpisodeInfoStatus { initial, loading, success, failure }

@JsonSerializable()
class EpisodeInfoState extends Equatable {
  const EpisodeInfoState({
    this.status = EpisodeInfoStatus.initial,
    this.episodeCache = const <int, Episode>{},
    this.episode,
  });

  @override
  factory EpisodeInfoState.fromJson(Map<String, dynamic> json) =>
      _$EpisodeInfoStateFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeInfoStateToJson(this);

  EpisodeInfoState copyWith({
    EpisodeInfoStatus? status,
    Map<int, Episode>? episodeCache,
    Episode? episode,
    bool forceSetEpisode = false,
  }) {
    return EpisodeInfoState(
      status: status ?? this.status,
      episodeCache: episodeCache ?? this.episodeCache,
      episode: episode != null || forceSetEpisode ? episode : this.episode,
    );
  }

  final EpisodeInfoStatus status;
  final Map<int, Episode> episodeCache;
  final Episode? episode;

  @override
  List<Object?> get props => [status, episodeCache, episode];
}

class EpisodeInfoInitial extends EpisodeInfoState {}
