// ignore_for_file: prefer_const_constructors, avoid_print
import 'dart:io';

import 'package:df_api/df_api.dart';
import 'package:test/test.dart';

const project = 'rimorse2-xphn';

void main() {
  late String serviceAccountJson;
  group('DfApi', () {
    setUpAll(() {
      serviceAccountJson = File('rimorse2-key.json').readAsStringSync();
    });
    test('can be instantiated', () async {
      final dfApi =
          DfApi(serviceAccountJson: serviceAccountJson, project: project);
      expect(
        dfApi,
        isNotNull,
      );
    });
    test('init', () async {
      final dfApi = DfApi(
        serviceAccountJson: serviceAccountJson,
        project: project,
      );
      await dfApi.init();
      dfApi.close();
    });
    test('query', () async {
      final dfApi = DfApi(
        serviceAccountJson: serviceAccountJson,
        project: project,
      );
      await dfApi.init();
      final response = await dfApi.textQuery(query: 'Tell me about morty');
      print(response.text);
      print(response.intentName);
      print(response.parameters);
      dfApi.close();
    });
  });
}
