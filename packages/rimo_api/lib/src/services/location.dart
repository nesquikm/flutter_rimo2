import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/constants.dart';
import 'package:rimo_api/src/services/models/models.dart';

/// {@template rimo_api_location}
/// The interface and models for an API providing access to location.
/// {@endtemplate}

class ApiLocationFailure implements Exception {}

/// {@macro rimo_api_location}
class ApiLocation {
  /// {@macro rimo_api_location}
  ApiLocation({required this.dio});

  /// Public Dio getter
  final Dio dio;

  /// Get all locations (filtred/paged)
  Future<PageLocation> getAllLocations({
    ApiLocationFilters? filters,
    PageLocation? prevPage,
    PageLocation? nextPage,
  }) async {
    try {
      final url = filters != null
          ? '${Constants.locationEndpoint}${filters.getQuery()}'
          : prevPage?.info.next != null
              ? prevPage!.info.next!
              : nextPage?.info.prev != null
                  ? nextPage!.info.prev!
                  : Constants.locationEndpoint;

      final response = await dio.get<Map<String, dynamic>>(url);

      final info =
          Info.fromJson(response.data!['info'] as Map<String, dynamic>);

      final locations = List<Location>.from(
        List<Map<String, dynamic>>.from(response.data!['results'] as List)
            .map<Location>(Location.fromJson),
      );

      return PageLocation(info: info, entities: locations);
    } catch (e) {
      log(e.toString());
      throw ApiLocationFailure();
    }
  }

  /// Get list of locations byt id
  Future<List<Location>> getListOfLocations({required List<int> ids}) async {
    try {
      final url = '${Constants.locationEndpoint}/$ids';

      final response = await dio.get<List<dynamic>>(url);

      return List<Location>.from(
        List<Map<String, dynamic>>.from(response.data!)
            .map<Location>(Location.fromJson),
      );
    } catch (e) {
      log(e.toString());
      throw ApiLocationFailure();
    }
  }
}
