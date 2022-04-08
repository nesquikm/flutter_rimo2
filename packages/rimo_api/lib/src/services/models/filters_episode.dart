import 'package:rimo_api/src/services/models/filters.dart';

/// {@template api_character_filters}
/// Provides filters for episode query
/// {@endtemplate}
class ApiEpisodeFilters extends ApiFilters {
  /// {@macro api_character_filters}
  ApiEpisodeFilters({this.name, this.episode});

  /// Episode name
  final String? name;

  /// Episode code
  final String? episode;

  @override
  Map<String, String?> getFields() {
    return {'name': name, 'episode': episode};
  }
}
