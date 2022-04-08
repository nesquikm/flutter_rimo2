// ignore_for_file: cascade_invocations

import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:rimo_api/rimo_api.dart';
import 'package:test/test.dart';

void main() {
  test('Character API: filters', () async {
    expect(ApiCharacterFilters().getQuery(), '');
    expect(ApiCharacterFilters(name: '_name_').getQuery(), '?name=_name_');
    expect(
      ApiCharacterFilters(status: CharacterStatus.alive).getQuery(),
      '?status=alive',
    );
    expect(
      ApiCharacterFilters(species: '_species_').getQuery(),
      '?species=_species_',
    );
    expect(ApiCharacterFilters(type: '_type_').getQuery(), '?type=_type_');
    expect(
      ApiCharacterFilters(gender: CharacterGender.male).getQuery(),
      '?gender=male',
    );

    expect(
      ApiCharacterFilters(
        name: '_name_',
        status: CharacterStatus.alive,
        species: '_species_',
        type: '_type_',
        gender: CharacterGender.male,
      ).getQuery(),
      '?name=_name_&status=alive&species=_species_&type=_type_&gender=male',
    );
  });

  test('Character API: networking', () async {
    final api = RimoApi();
    final dioAdapter = DioAdapter(dio: api.dio);

    dioAdapter.onGet(
      'character/[1, 183]',
      (server) => server.reply(200, testCharactersResponse),
    );

    dioAdapter.onGet(
      'character',
      (server) => server.reply(200, testCharacterPageResponse),
    );

    dioAdapter.onGet(
      'character?name=Earth',
      (server) => server.reply(200, testCharacterPageResponse),
    );

    expect(
      (await api.character.getListOfCharacters(ids: [1, 183])).elementAt(1),
      testCharacter,
    );

    expect(
      (await api.character.getAllCharacters()).entities.elementAt(1),
      testCharacter,
    );

    expect(
      (await api.character
              .getAllCharacters(filters: ApiCharacterFilters(name: 'Earth')))
          .entities
          .elementAt(1),
      testCharacter,
    );

    expect(
      (await api.character.getAllCharacters()).info,
      testInfo,
    );
  });
}

const testCharactersResponse = [
  {
    'id': 1,
    'name': 'Rick Sanchez',
    'status': 'Alive',
    'species': 'Human',
    'type': '',
    'gender': 'Male',
    'origin': {
      'name': 'Earth (C-137)',
      'url': 'https://rickandmortyapi.com/api/location/1'
    },
    'location': {
      'name': 'Citadel of Ricks',
      'url': 'https://rickandmortyapi.com/api/location/3'
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
    'episode': [
      'https://rickandmortyapi.com/api/episode/1',
      'https://rickandmortyapi.com/api/episode/2',
    ],
    'url': 'https://rickandmortyapi.com/api/character/1',
    'created': '2017-11-04T18:48:46.250Z'
  },
  {
    'id': 183,
    'name': 'Johnny Depp',
    'status': 'Alive',
    'species': 'Human',
    'type': '',
    'gender': 'Male',
    'origin': {
      'name': 'Earth (C-500A)',
      'url': 'https://rickandmortyapi.com/api/location/23'
    },
    'location': {
      'name': 'Earth (C-500A)',
      'url': 'https://rickandmortyapi.com/api/location/23'
    },
    'image': 'https://rickandmortyapi.com/api/character/avatar/183.jpeg',
    'episode': ['https://rickandmortyapi.com/api/episode/8'],
    'url': 'https://rickandmortyapi.com/api/character/183',
    'created': '2017-12-29T18:51:29.693Z'
  }
];

const testCharacterPageResponse = {
  'info': {
    'count': 826,
    'pages': 42,
    'next': null,
    'prev': 'https://rickandmortyapi.com/api/character?page=2'
  },
  'results': testCharactersResponse,
};

final testCharacter = Character(
  id: 183,
  name: 'Johnny Depp',
  status: CharacterStatus.alive,
  species: 'Human',
  type: '',
  gender: CharacterGender.male,
  origin: const CharacterLocation(
    name: 'Earth (C-500A)',
    url: 'https://rickandmortyapi.com/api/location/23',
  ),
  location: const CharacterLocation(
    name: 'Earth (C-500A)',
    url: 'https://rickandmortyapi.com/api/location/23',
  ),
  image: 'https://rickandmortyapi.com/api/character/avatar/183.jpeg',
  episode: const [
    'https://rickandmortyapi.com/api/episode/8',
  ],
  url: 'https://rickandmortyapi.com/api/character/183',
  created: DateTime.parse('2017-12-29T18:51:29.693Z'),
);

const testInfo = Info(
  count: 826,
  pages: 42,
  next: null,
  prev: 'https://rickandmortyapi.com/api/character?page=2',
);
