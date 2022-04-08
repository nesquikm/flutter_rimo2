import 'dart:convert';

import 'package:rimo_api/rimo_api.dart';
import 'package:test/test.dart';

String episodeJson = '''
{
  "id": 1,
  "name": "Pilot",
  "air_date": "December 2, 2013",
  "episode": "S01E01",
  "characters": [
    "https://rickandmortyapi.com/api/character/1",
    "https://rickandmortyapi.com/api/character/2"
  ],
  "url": "https://rickandmortyapi.com/api/episode/1",
  "created": "2017-11-10T12:56:33.798Z"
}
''';

void main() {
  test('Episode', () {
    final episodeJsonAsList = jsonDecode(episodeJson) as Map<String, dynamic>;
    final episodeFromJson = Episode.fromJson(episodeJsonAsList);
    final episodeProto = Episode(
      id: 1,
      name: 'Pilot',
      airDate: 'December 2, 2013',
      episode: 'S01E01',
      characters: const [
        'https://rickandmortyapi.com/api/character/1',
        'https://rickandmortyapi.com/api/character/2',
      ],
      url: 'https://rickandmortyapi.com/api/episode/1',
      created: DateTime.parse('2017-11-10T12:56:33.798Z'),
    );

    expect(episodeFromJson, episodeProto);
  });
}
