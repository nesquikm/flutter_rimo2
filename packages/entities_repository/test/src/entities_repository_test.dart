// ignore_for_file: prefer_const_constructors
import 'package:entities_repository/entities_repository.dart';
import 'package:test/test.dart';

void main() {
  group('EntitiesRepository', () {
    test('can be instantiated', () {
      expect(EntitiesRepository(), isNotNull);
    });
    test('ApiCharacter is present', () {
      expect(EntitiesRepository().apiCharacter, isNotNull);
    });
    test('ApiEpisode is present', () {
      expect(EntitiesRepository().apiEpisode, isNotNull);
    });
    test('ApiLocation is present', () {
      expect(EntitiesRepository().apiLocation, isNotNull);
    });
  });
}
