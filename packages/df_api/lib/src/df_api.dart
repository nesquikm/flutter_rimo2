import 'package:df_api/src/models/models.dart';
import 'package:googleapis/dialogflow/v2.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';

/// {@template df_api}
/// Dialogflow gRPC API
/// {@endtemplate}

class DfApiFailure implements Exception {}

/// {@macro df_api}
class DfApi {
  /// {@macro df_api}
  DfApi({required Object serviceAccountJson, required String project})
      : _serviceAccountJson = serviceAccountJson,
        _project = project;

  final Object _serviceAccountJson;
  final String _project;

  /// Init DfApi
  Future<void> init() async {
    _httpClient = await _obtainAuthenticatedClient();
    _dialogflowApi = DialogflowApi(_httpClient!);

    _session = 'projects/$_project/agent/sessions/${const Uuid().v4()}';
  }

  /// Close DfApi
  void close() {
    _httpClient?.close();
    _httpClient = null;
  }

  /// Send a query to Dialogflow
  Future<DfApiTextResponse> textQuery({
    String languageCode = 'en',
    required String query,
  }) async {
    if (_dialogflowApi == null || _dialogflowApi == null) throw DfApiFailure();

    final queryTextInput = GoogleCloudDialogflowV2TextInput(
      languageCode: languageCode,
      text: query,
    );
    final queryInput = GoogleCloudDialogflowV2QueryInput(text: queryTextInput);
    final request =
        GoogleCloudDialogflowV2DetectIntentRequest(queryInput: queryInput);

    final response = await _dialogflowApi!.projects.agent.sessions
        .detectIntent(request, _session!);

    return DfApiTextResponse(
      text: response.queryResult?.fulfillmentMessages?[0].text?.text?[0] ?? '',
      intentName: response.queryResult?.intent?.displayName,
      parameters: response.queryResult?.parameters
          ?.map((key, value) => MapEntry(key, value.toString())),
    );
  }

  late DialogflowApi? _dialogflowApi;
  late String? _session;
  late Client? _httpClient;

  Future<AuthClient> _obtainAuthenticatedClient() async {
    final accountCredentials =
        ServiceAccountCredentials.fromJson(_serviceAccountJson);
    final scopes = [DialogflowApi.dialogflowScope];

    final AuthClient client =
        await clientViaServiceAccount(accountCredentials, scopes);

    return client;
  }
}
