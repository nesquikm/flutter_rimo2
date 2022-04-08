part of 'characters_bloc.dart';

enum CharactersStatus { initial, loading, success, failure }

@JsonSerializable()
class CharactersState extends Equatable {
  const CharactersState({
    this.status = CharactersStatus.initial,
    this.characters = const <Character>[],
    this.lastPage,
  });

  @override
  factory CharactersState.fromJson(Map<String, dynamic> json) =>
      _$CharactersStateFromJson(json);

  Map<String, dynamic> toJson() => _$CharactersStateToJson(this);

  CharactersState copyWith({
    CharactersStatus? status,
    List<Character>? characters,
    PageCharacter? lastPage,
  }) {
    return CharactersState(
      status: status ?? this.status,
      characters: characters ?? this.characters,
      lastPage: lastPage ?? this.lastPage,
    );
  }

  final PageCharacter? lastPage;

  final CharactersStatus status;
  final List<Character> characters;
  bool get fetchedAll => lastPage != null && lastPage?.info.next == null;

  @override
  List<Object?> get props => [lastPage, status, characters];
}

class CharactersInitial extends CharactersState {}
