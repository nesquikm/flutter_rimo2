import 'package:json_annotation/json_annotation.dart';
import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/models/page.dart';

part 'page_location.g.dart';

/// {@template location_page}
/// PageLocation includes Info and list of characters
/// {@endtemplate}
@JsonSerializable()
class PageLocation extends Page<Location> {
  /// {@macro location_page}
  const PageLocation({required Info info, required List<Location> entities})
      : super(info, entities);

  /// Create PageLocation from json
  factory PageLocation.fromJson(Map<String, dynamic> json) =>
      _$PageLocationFromJson(json);

  /// Store PageLocation to json
  Map<String, dynamic> toJson() => _$PageLocationToJson(this);

  @override
  List<Object> get props => [
        info,
        entities,
      ];
}
