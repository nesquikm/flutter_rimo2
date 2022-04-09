part of 'character_info_bloc.dart';

enum CharacterInfoStatus { initial, loading, success, failure }

@JsonSerializable()
class CharacterInfoState extends Equatable {
  const CharacterInfoState({
    this.status = CharacterInfoStatus.initial,
    this.characterCache = const <int, Character>{},
    this.character,
  });

  @override
  factory CharacterInfoState.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfoStateFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterInfoStateToJson(this);

  CharacterInfoState copyWith({
    CharacterInfoStatus? status,
    Map<int, Character>? characterCache,
    Character? character,
    bool forceSetCharacter = false,
  }) {
    return CharacterInfoState(
      status: status ?? this.status,
      characterCache: characterCache ?? this.characterCache,
      character:
          character != null || forceSetCharacter ? character : this.character,
    );
  }

  final CharacterInfoStatus status;
  final Map<int, Character> characterCache;
  final Character? character;

  @override
  List<Object?> get props => [status, characterCache, character];
}

class CharacterInfoInitial extends CharacterInfoState {}
