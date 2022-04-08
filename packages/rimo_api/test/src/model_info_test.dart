import 'dart:convert';

import 'package:rimo_api/src/models/info.dart';
import 'package:test/test.dart';

String infoJson = '''
{
  "count": 826,
  "pages": 42,
  "next": null,
  "prev": "https://rickandmortyapi.com/api/character/?page=41"
}
''';

void main() {
  test('Info', () {
    final infoJsonAsList = jsonDecode(infoJson) as Map<String, dynamic>;
    final infoFromJson = Info.fromJson(infoJsonAsList);
    const infoProto = Info(
      count: 826,
      pages: 42,
      next: null,
      prev: 'https://rickandmortyapi.com/api/character/?page=41',
    );

    expect(infoFromJson, infoProto);
  });
}
