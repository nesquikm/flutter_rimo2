import 'package:json_annotation/json_annotation.dart';
import 'package:rimo_api/src/models/models.dart';
import 'package:rimo_api/src/services/models/page.dart';

part 'page_episode.g.dart';

/// {@template episode_page}
/// PageEpisode includes Info and list of characters
/// {@endtemplate}
@JsonSerializable()
class PageEpisode extends Page<Episode> {
  /// {@macro episode_page}
  const PageEpisode({required Info info, required List<Episode> entities})
      : super(info, entities);

  /// Create PageEpisode from json
  factory PageEpisode.fromJson(Map<String, dynamic> json) =>
      _$PageEpisodeFromJson(json);

  /// Store PageEpisode to json
  Map<String, dynamic> toJson() => _$PageEpisodeToJson(this);

  @override
  List<Object> get props => [
        info,
        entities,
      ];
}
