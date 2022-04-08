import 'package:dio/dio.dart';
import 'package:rimo_api/src/services/character.dart';
import 'package:rimo_api/src/services/constants.dart';
import 'package:rimo_api/src/services/episode.dart';
import 'package:rimo_api/src/services/location.dart';

export 'services/models/models.dart';
export 'services/services.dart';

/// {@template rimo_api}
/// The interface and models for an API providing access to backend.
/// {@endtemplate}
class RimoApi {
  /// {@macro rimo_api}
  RimoApi() : dio = Dio(_options) {
    location = ApiLocation(dio: dio);
    episode = ApiEpisode(dio: dio);
    character = ApiCharacter(dio: dio);
  }

  static final _options = BaseOptions(
    baseUrl: Constants.baseURL,
  );

  /// Public Dio getter
  final Dio dio;

  /// Ready for use ApiLocation instance
  late final ApiLocation location;

  /// Ready for use ApiEpisode instance
  late final ApiEpisode episode;

  /// Ready for use ApiCharacter instance
  late final ApiCharacter character;
}
