import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/constants.dart';
import 'package:rimo_api/src/services/models/models.dart';

/// {@template rimo_api_episode}
/// The interface and models for an API providing access to episode.
/// {@endtemplate}

class ApiEpisodeFailure implements Exception {}

/// {@macro rimo_api_episode}
class ApiEpisode {
  /// {@macro rimo_api_episode}
  ApiEpisode({required this.dio});

  /// Public Dio getter
  final Dio dio;

  /// Get all episodes (filtred/paged)
  Future<PageEpisode> getAllEpisodes({
    ApiEpisodeFilters? filters,
    PageEpisode? prevPage,
    PageEpisode? nextPage,
  }) async {
    try {
      final url = filters != null
          ? '${Constants.episodeEndpoint}${filters.getQuery()}'
          : prevPage?.info.next != null
              ? prevPage!.info.next!
              : nextPage?.info.prev != null
                  ? nextPage!.info.prev!
                  : Constants.episodeEndpoint;

      final response = await dio.get<Map<String, dynamic>>(url);

      final info =
          Info.fromJson(response.data!['info'] as Map<String, dynamic>);

      final episodes = List<Episode>.from(
        List<Map<String, dynamic>>.from(response.data!['results'] as List)
            .map<Episode>(Episode.fromJson),
      );

      return PageEpisode(info: info, entities: episodes);
    } catch (e) {
      log(e.toString());
      throw ApiEpisodeFailure();
    }
  }

  /// Get list of episodes byt id
  Future<List<Episode>> getListOfEpisodes({required List<int> ids}) async {
    try {
      final url = '${Constants.episodeEndpoint}/$ids';

      final response = await dio.get<List<dynamic>>(url);

      return List<Episode>.from(
        List<Map<String, dynamic>>.from(response.data!)
            .map<Episode>(Episode.fromJson),
      );
    } catch (e) {
      log(e.toString());
      throw ApiEpisodeFailure();
    }
  }
}
