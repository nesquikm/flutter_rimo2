import 'package:dio/dio.dart';
import 'package:rimo_api/rimo_api.dart';

/// {@template entities_repository}
/// A repository that handles character, location and episode related requests.
/// {@endtemplate}
class EntitiesRepository {
  /// {@macro entities_repository}
  EntitiesRepository() : _rimoApi = RimoApi();

  /// Public Dio getter
  Dio get dio => _rimoApi.dio;

  late final RimoApi _rimoApi;

  /// Public ApiCharacter getter
  ApiCharacter get apiCharacter => _rimoApi.character;

  /// Public ApiLocation getter
  ApiLocation get apiLocation => _rimoApi.location;

  /// Public ApiEpisode getter
  ApiEpisode get apiEpisode => _rimoApi.episode;
}
