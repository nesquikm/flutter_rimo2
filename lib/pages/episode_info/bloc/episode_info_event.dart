part of 'episode_info_bloc.dart';

abstract class EpisodeInfoEvent extends Equatable {
  const EpisodeInfoEvent();

  @override
  List<Object> get props => [];
}

class EpisodeInfoRefresh extends EpisodeInfoEvent {}

class EpisodeInfoFetchById extends EpisodeInfoEvent {
  const EpisodeInfoFetchById({required this.id, this.refresh = false});
  final int id;
  final bool refresh;

  @override
  List<Object> get props => [id, refresh];
}
