part of 'episodes_bloc.dart';

abstract class EpisodesEvent extends Equatable {
  const EpisodesEvent();

  @override
  List<Object> get props => [];
}

class EpisodesReset extends EpisodesEvent {}

class EpisodesFetchFirstPage extends EpisodesEvent {}

class EpisodesFetchNextPage extends EpisodesEvent {
  const EpisodesFetchNextPage({this.reset = false});
  final bool reset;

  @override
  List<Object> get props => [reset];
}
