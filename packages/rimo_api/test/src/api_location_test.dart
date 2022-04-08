// ignore_for_file: cascade_invocations

import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rimo_api/rimo_api.dart';
import 'package:test/test.dart';

void main() {
  test('Location API: filters', () async {
    expect(ApiLocationFilters().getQuery(), '');
    expect(ApiLocationFilters(name: '_name_').getQuery(), '?name=_name_');
    expect(ApiLocationFilters(type: '_type_').getQuery(), '?type=_type_');
    expect(
      ApiLocationFilters(dimension: '_dimension_').getQuery(),
      '?dimension=_dimension_',
    );
    expect(
      ApiLocationFilters(
        name: '_name_',
        type: '_type_',
        dimension: '_dimension_',
      ).getQuery(),
      '?name=_name_&type=_type_&dimension=_dimension_',
    );
  });

  test('Location API: networking', () async {
    final api = RimoApi();
    final dioAdapter = DioAdapter(dio: api.dio);

    dioAdapter.onGet(
      'location/[3, 7, 11]',
      (server) => server.reply(200, testLocationsResponse),
    );

    dioAdapter.onGet(
      'location',
      (server) => server.reply(200, testLocationPageResponse),
    );

    dioAdapter.onGet(
      'location?name=Earth',
      (server) => server.reply(200, testLocationPageResponse),
    );

    expect(
      (await api.location.getListOfLocations(ids: [3, 7, 11])).elementAt(1),
      testLocation,
    );

    expect(
      (await api.location.getAllLocations()).entities.elementAt(1),
      testLocation,
    );

    expect(
      (await api.location
              .getAllLocations(filters: ApiLocationFilters(name: 'Earth')))
          .entities
          .elementAt(1),
      testLocation,
    );

    expect(
      (await api.location.getAllLocations()).info,
      testInfo,
    );
  });
}

const testLocationsResponse = [
  {
    'id': 3,
    'name': 'Citadel of Ricks',
    'type': 'Space station',
    'dimension': 'unknown',
    'residents': [
      'https://rickandmortyapi.com/api/character/8',
      'https://rickandmortyapi.com/api/character/14',
      'https://rickandmortyapi.com/api/character/15',
    ],
    'url': 'https://rickandmortyapi.com/api/location/3',
    'created': '2017-11-10T13:08:13.191Z'
  },
  {
    'id': 7,
    'name': 'Immortality Field Resort',
    'type': 'Resort',
    'dimension': 'unknown',
    'residents': [
      'https://rickandmortyapi.com/api/character/23',
      'https://rickandmortyapi.com/api/character/204',
      'https://rickandmortyapi.com/api/character/320'
    ],
    'url': 'https://rickandmortyapi.com/api/location/7',
    'created': '2017-11-10T13:09:17.136Z'
  },
  {
    'id': 11,
    'name': 'Bepis 9',
    'type': 'Planet',
    'dimension': 'unknown',
    'residents': ['https://rickandmortyapi.com/api/character/35'],
    'url': 'https://rickandmortyapi.com/api/location/11',
    'created': '2017-11-18T11:26:03.325Z'
  }
];

const testLocationPageResponse = {
  'info': {
    'count': 826,
    'pages': 42,
    'next': null,
    'prev': 'https://rickandmortyapi.com/api/character/?page=41'
  },
  'results': testLocationsResponse,
};

final testLocation = Location(
  id: 7,
  name: 'Immortality Field Resort',
  type: 'Resort',
  dimension: 'unknown',
  residents: const [
    'https://rickandmortyapi.com/api/character/23',
    'https://rickandmortyapi.com/api/character/204',
    'https://rickandmortyapi.com/api/character/320',
  ],
  url: 'https://rickandmortyapi.com/api/location/7',
  created: DateTime.parse('2017-11-10T13:09:17.136Z'),
);

const testInfo = Info(
  count: 826,
  pages: 42,
  next: null,
  prev: 'https://rickandmortyapi.com/api/character/?page=41',
);
