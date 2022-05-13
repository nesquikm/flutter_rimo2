import 'package:json_annotation/json_annotation.dart';
import 'package:rimo_api/src/models/entity.dart';

part 'location.g.dart';

/// A location class
@JsonSerializable()
class Location extends Entity {
  /// Create explicit location
  const Location({
    required super.id,
    required this.name,
    required this.type,
    required this.dimension,
    required this.residents,
    required this.url,
    required this.created,
  });

  /// Create location from json
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// Store location to json
  Map<String, dynamic> toJson() => _$LocationToJson(this);

  /// The name of the location.
  final String name;

  /// The type of the location.
  final String type;

  /// The dimension in which the location is located.
  final String dimension;

  /// List of character who have been last seen in the location.
  final List<String> residents;

  /// Link to the location's own endpoint.
  final String url;

  /// Time at which the location was created in the database.
  final DateTime created;

  @override
  List<Object> get props => [
        id,
        name,
        type,
        dimension,
        residents,
        url,
        created,
      ];
}
