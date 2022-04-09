part of 'character_info_bloc.dart';

abstract class CharacterInfoEvent extends Equatable {
  const CharacterInfoEvent();

  @override
  List<Object> get props => [];
}

class CharacterInfoRefresh extends CharacterInfoEvent {}

class CharacterInfoFetchById extends CharacterInfoEvent {
  const CharacterInfoFetchById({required this.id, this.refresh = false});
  final int id;
  final bool refresh;

  @override
  List<Object> get props => [id, refresh];
}
