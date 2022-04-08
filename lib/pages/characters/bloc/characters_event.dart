part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {
  const CharactersEvent();

  @override
  List<Object> get props => [];
}

class CharactersReset extends CharactersEvent {}

class CharactersFetchFirstPage extends CharactersEvent {}

class CharactersFetchNextPage extends CharactersEvent {
  const CharactersFetchNextPage({this.reset = false});
  final bool reset;

  @override
  List<Object> get props => [reset];
}
