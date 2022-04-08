import 'dart:convert';

import 'package:rimo_api/rimo_api.dart';
import 'package:test/test.dart';

String locationJson = '''
{
  "id": 1,
  "name": "Earth (C-137)",
  "type": "Planet",
  "dimension": "Dimension C-137",
  "residents": [
    "https://rickandmortyapi.com/api/character/38",
    "https://rickandmortyapi.com/api/character/45"
  ],
  "url": "https://rickandmortyapi.com/api/location/1",
  "created": "2017-11-10T12:42:04.162Z"
}
''';

void main() {
  test('Location', () {
    final locationJsonAsList = jsonDecode(locationJson) as Map<String, dynamic>;
    final locationFromJson = Location.fromJson(locationJsonAsList);
    final locationProto = Location(
      id: 1,
      name: 'Earth (C-137)',
      type: 'Planet',
      dimension: 'Dimension C-137',
      residents: const [
        'https://rickandmortyapi.com/api/character/38',
        'https://rickandmortyapi.com/api/character/45',
      ],
      url: 'https://rickandmortyapi.com/api/location/1',
      created: DateTime.parse('2017-11-10T12:42:04.162Z'),
    );

    expect(locationFromJson, locationProto);
  });
}
