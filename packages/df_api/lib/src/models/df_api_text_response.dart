/// {@template text_response}
/// Test response
/// {@endtemplate}
class DfApiTextResponse {
  /// {@macro text_response}
  DfApiTextResponse({
    required this.text,
    this.intentName,
    this.parameters,
  });

  /// Response text
  final String text;

  /// Intent name
  final String? intentName;

  /// Response parameters
  final Map<String, String>? parameters;
}
