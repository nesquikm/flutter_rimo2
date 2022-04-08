// ignore_for_file: prefer_const_constructors
import 'package:df_repository/df_repository.dart';
import 'package:test/test.dart';

void main() {
  group('DfRepository', () {
    test('can be instantiated', () {
      expect(
        DfRepository(
          serviceAccountJson: '_serviceAccountJson_',
          project: '_project_',
        ),
        isNotNull,
      );
    });
  });
}
