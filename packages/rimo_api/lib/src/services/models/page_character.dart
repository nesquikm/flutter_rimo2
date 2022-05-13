import 'package:json_annotation/json_annotation.dart';
import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/models/page.dart';

part 'page_character.g.dart';

/// {@template character_page}
/// PageCharacter includes Info and list of characters
/// {@endtemplate}
@JsonSerializable()
class PageCharacter extends Page<Character> {
  /// {@macro character_page}
  const PageCharacter({required super.info, required super.entities});

  /// Create PageCharacter from json
  factory PageCharacter.fromJson(Map<String, dynamic> json) =>
      _$PageCharacterFromJson(json);

  /// Store PageCharacter to json
  Map<String, dynamic> toJson() => _$PageCharacterToJson(this);

  @override
  List<Object> get props => [
        info,
        entities,
      ];
}
