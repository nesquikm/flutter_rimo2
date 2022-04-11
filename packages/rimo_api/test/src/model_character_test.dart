import 'dart:convert';

import 'package:rimo_api/rimo_api.dart';
import 'package:test/test.dart';

String characterJson = '''
{
  "id": 1,
  "name": "Rick Sanchez",
  "status": "Alive",
  "species": "Human",
  "type": "",
  "gender": "Male",
  "origin": {
    "name": "Earth (C-137)",
    "url": "https://rickandmortyapi.com/api/location/1"
  },
  "location": {
    "name": "Citadel of Ricks",
    "url": "https://rickandmortyapi.com/api/location/3"
  },
  "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
  "episode": [
    "https://rickandmortyapi.com/api/episode/1",
    "https://rickandmortyapi.com/api/episode/2"
  ],
  "url": "https://rickandmortyapi.com/api/character/1",
  "created": "2017-11-04T18:48:46.250Z"
}
''';

void main() {
  test('Character', () {
    final characterJsonAsList =
        jsonDecode(characterJson) as Map<String, dynamic>;
    final characterFromJson = Character.fromJson(characterJsonAsList);
    final characterProto = Character(
      id: 1,
      name: 'Rick Sanchez',
      status: CharacterStatus.alive,
      species: 'Human',
      type: '',
      gender: CharacterGender.male,
      origin: const CharacterLocation(
        name: 'Earth (C-137)',
        url: 'https://rickandmortyapi.com/api/location/1',
      ),
      location: const CharacterLocation(
        name: 'Citadel of Ricks',
        url: 'https://rickandmortyapi.com/api/location/3',
      ),
      image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg',
      episode: const [
        'https://rickandmortyapi.com/api/episode/1',
        'https://rickandmortyapi.com/api/episode/2',
      ],
      url: 'https://rickandmortyapi.com/api/character/1',
      created: DateTime.parse('2017-11-04T18:48:46.250Z'),
    );

    expect(characterFromJson, characterProto);
  });

  test('Character location', () {
    const characterLocation = CharacterLocation(
      name: '_name_',
      url: 'https://rickandmortyapi.com/api/location/42',
    );

    expect(characterLocation.id, 42);
  });
}
