import 'package:df_api/df_api.dart';

/// {@template df_repository}
/// A repository that handles Dialogflow interactions
/// {@endtemplate}
class DfRepository {
  /// {@macro df_repository}
  DfRepository({required Object serviceAccountJson, required String project})
      : dfApi = DfApi(serviceAccountJson: serviceAccountJson, project: project);

  /// Ready for use DfApi instance
  final DfApi dfApi;
}
