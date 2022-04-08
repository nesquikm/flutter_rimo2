part of 'episodes_bloc.dart';

enum EpisodesStatus { initial, loading, success, failure }

@JsonSerializable()
class EpisodesState extends Equatable {
  const EpisodesState({
    this.status = EpisodesStatus.initial,
    this.episodes = const <Episode>[],
    this.lastPage,
  });

  @override
  factory EpisodesState.fromJson(Map<String, dynamic> json) =>
      _$EpisodesStateFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodesStateToJson(this);

  EpisodesState copyWith({
    EpisodesStatus? status,
    List<Episode>? episodes,
    PageEpisode? lastPage,
  }) {
    return EpisodesState(
      status: status ?? this.status,
      episodes: episodes ?? this.episodes,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  final PageEpisode? lastPage;

  final EpisodesStatus status;
  final List<Episode> episodes;
  bool get fetchedAll => lastPage != null && lastPage?.info.next == null;

  @override
  List<Object?> get props => [lastPage, status, episodes];
}

class EpisodesInitial extends EpisodesState {}
