import 'package:rimo_api/src/services/models/filters.dart';

/// {@template api_character_filters}
/// Provides filters for location query
/// {@endtemplate}
class ApiLocationFilters extends ApiFilters {
  /// {@macro api_character_filters}
  ApiLocationFilters({this.name, this.type, this.dimension});

  /// Location name
  final String? name;

  /// Location type
  final String? type;

  /// Location dimension
  final String? dimension;

  @override
  Map<String, String?> getFields() {
    return {'name': name, 'type': type, 'dimension': dimension};
  }
}
