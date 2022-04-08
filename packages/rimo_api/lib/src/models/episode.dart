import 'package:json_annotation/json_annotation.dart';
import 'package:rimo_api/src/models/entity.dart';

part 'episode.g.dart';

/// An episode class
@JsonSerializable()
class Episode extends Entity {
  /// Create explicit episode
  const Episode({
    required int id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  }) : super(id: id);

  /// Create episode from json
  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);

  /// Store episode to json
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  /// The name of the episode.
  final String name;

  /// The air date of the episode.
  @JsonKey(name: 'air_date')
  final String airDate;

  /// The code of the episode.
  final String episode;

  /// List of characters who have been seen in the episode.
  final List<String> characters;

  /// Link to the episode's own endpoint.
  final String url;

  /// Time at which the episode was created in the database.
  final DateTime created;

  @override
  List<Object> get props => [
        id,
        name,
        airDate,
        episode,
        characters,
        url,
        created,
      ];
}
