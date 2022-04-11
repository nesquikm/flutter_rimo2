import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:rimo_api/src/models/entity.dart';

part 'character.g.dart';

/// A chacacter status
enum CharacterStatus {
  /// The character is alive
  @JsonValue('Alive')
  alive,

  /// The character is dead
  @JsonValue('Dead')
  dead,

  /// The character is in unknown status
  @JsonValue('unknown')
  unknown,
}

/// A chacacter gender
enum CharacterGender {
  /// The character is female
  @JsonValue('Female')
  female,

  /// The character is male
  @JsonValue('Male')
  male,

  /// The character is genderless
  @JsonValue('Genderless')
  genderless,

  /// The character's gender is unknown
  @JsonValue('unknown')
  unknown,
}

/// A class for location linking
@JsonSerializable()
class CharacterLocation extends Equatable {
  /// Create explicit character location
  const CharacterLocation({
    required this.name,
    required this.url,
  });

  /// Create character location from json
  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationFromJson(json);

  /// Store character location to json
  Map<String, dynamic> toJson() => _$CharacterLocationToJson(this);

  /// The name of the location.
  final String name;

  /// The url of the location.
  final String url;

  /// The id of the location.
  int get id => int.parse(RegExp(r'[0-9]+$').firstMatch(url)!.group(0)!);

  @override
  List<Object> get props => [
        name,
        url,
      ];
}

/// A character class
@JsonSerializable()
class Character extends Entity {
  /// Create explicit character
  const Character({
    required int id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  }) : super(id: id);

  /// Create character location from json
  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  /// Store character to json
  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  /// The name of the character.
  final String name;

  /// The status of the character (CharacterStatus)
  final CharacterStatus status;

  /// The species of the character.
  final String species;

  /// The type or subspecies of the character.
  final String type;

  /// The gender of the character (CharacterGender)
  final CharacterGender gender;

  /// Name and link to the character's origin location.
  final CharacterLocation origin;

  /// Name and link to the character's last known location endpoint.
  final CharacterLocation location;

  /// Link to the character's image. All images are 300x300px and most are
  /// medium shots or portraits since they are intended to be used as avatars.
  final String image;

  ///List of episodes in which this character appeared.
  final List<String> episode;

  /// Link to the character's own URL endpoint.
  final String url;

  ///Time at which the character was created in the database.
  final DateTime created;

  @override
  List<Object> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        episode,
        url,
        created,
      ];
}
