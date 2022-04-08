/// ApiFilters provides method for converting present fields into query string
abstract class ApiFilters {
  /// Subclasses should provide list of fields for converting them into query
  /// string
  Map<String, String?> getFields();

  /// Get query string for present fields
  String getQuery() {
    var query = '';

    getFields().entries.forEach((element) {
      if (element.value != null && element.value!.isNotEmpty) {
        query += query.isEmpty ? '?' : '&';
        query += '${element.key}=${element.value}';
      }
    });

    return query;
  }
}
