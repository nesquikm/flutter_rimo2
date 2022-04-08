import 'package:enum_to_string/enum_to_string.dart';
import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/models/filters.dart';

/// {@template api_character_filters}
/// Provides filters for character query
/// {@endtemplate}
class ApiCharacterFilters extends ApiFilters {
  /// {@macro api_character_filters}
  ApiCharacterFilters({
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
  });

  /// Character name
  final String? name;

  /// Character status
  final CharacterStatus? status;

  /// Character species
  final String? species;

  /// Character type
  final String? type;

  /// Character gender
  final CharacterGender? gender;

  @override
  Map<String, String?> getFields() {
    return {
      'name': name,
      'status': status != null ? EnumToString.convertToString(status) : null,
      'species': species,
      'type': type,
      'gender': gender != null ? EnumToString.convertToString(gender) : null,
    };
  }
}
