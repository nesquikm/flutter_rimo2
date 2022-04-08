// ignore_for_file: cascade_invocations

import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rimo_api/rimo_api.dart';
import 'package:test/test.dart';

void main() {
  test('Episode API: filters', () async {
    expect(ApiEpisodeFilters().getQuery(), '');
    expect(ApiEpisodeFilters(name: '_name_').getQuery(), '?name=_name_');
    expect(
      ApiEpisodeFilters(episode: '_episode_').getQuery(),
      '?episode=_episode_',
    );
    expect(
      ApiEpisodeFilters(
        name: '_name_',
        episode: '_episode_',
      ).getQuery(),
      '?name=_name_&episode=_episode_',
    );
  });

  test('Episode API: networking', () async {
    final api = RimoApi();
    final dioAdapter = DioAdapter(dio: api.dio);

    dioAdapter.onGet(
      'episode/[10, 28, 30]',
      (server) => server.reply(200, testEpisodesResponse),
    );

    dioAdapter.onGet(
      'episode',
      (server) => server.reply(200, testEpisodePageResponse),
    );

    dioAdapter.onGet(
      'episode?name=Earth',
      (server) => server.reply(200, testEpisodePageResponse),
    );

    expect(
      (await api.episode.getListOfEpisodes(ids: [10, 28, 30])).elementAt(1),
      testEpisode,
    );

    expect(
      (await api.episode.getAllEpisodes()).entities.elementAt(1),
      testEpisode,
    );

    expect(
      (await api.episode
              .getAllEpisodes(filters: ApiEpisodeFilters(name: 'Earth')))
          .entities
          .elementAt(1),
      testEpisode,
    );

    expect(
      (await api.episode.getAllEpisodes()).info,
      testInfo,
    );
  });
}

const testEpisodesResponse = [
  {
    'id': 10,
    'name': 'Close Rick-counters of the Rick Kind',
    'air_date': 'April 7, 2014',
    'episode': 'S01E10',
    'characters': [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    'url': 'https://rickandmortyapi.com/api/episode/10',
    'created': '2017-11-10T12:56:34.747Z'
  },
  {
    'id': 28,
    'name': 'The Ricklantis Mixup',
    'air_date': 'September 10, 2017',
    'episode': 'S03E07',
    'characters': [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    'url': 'https://rickandmortyapi.com/api/episode/28',
    'created': '2017-11-10T12:56:36.618Z'
  },
  {
    'id': 30,
    'name': "The ABC's of Beth",
    'air_date': 'September 24, 2017',
    'episode': 'S03E09',
    'characters': [
      'https://rickandmortyapi.com/api/character/1',
      'https://rickandmortyapi.com/api/character/2',
    ],
    'url': 'https://rickandmortyapi.com/api/episode/30',
    'created': '2017-11-10T12:56:36.828Z'
  }
];

const testEpisodePageResponse = {
  'info': {
    'count': 51,
    'pages': 3,
    'next': null,
    'prev': 'https://rickandmortyapi.com/api/episode/?page=2'
  },
  'results': testEpisodesResponse,
};

final testEpisode = Episode(
  id: 28,
  name: 'The Ricklantis Mixup',
  airDate: 'September 10, 2017',
  episode: 'S03E07',
  characters: const [
    'https://rickandmortyapi.com/api/character/1',
    'https://rickandmortyapi.com/api/character/2',
  ],
  url: 'https://rickandmortyapi.com/api/episode/28',
  created: DateTime.parse('2017-11-10T12:56:36.618Z'),
);

const testInfo = Info(
  count: 51,
  pages: 3,
  next: null,
  prev: 'https://rickandmortyapi.com/api/episode/?page=2',
);
