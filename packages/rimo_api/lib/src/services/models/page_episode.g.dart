// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'page_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageEpisode _$PageEpisodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'PageEpisode',
      json,
      ($checkedConvert) {
        final val = PageEpisode(
          info: $checkedConvert(
              'info', (v) => Info.fromJson(v as Map<String, dynamic>)),
          entities: $checkedConvert(
              'entities',
              (v) => (v as List<dynamic>)
                  .map((e) => Episode.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PageEpisodeToJson(PageEpisode instance) =>
    <String, dynamic>{
      'info': instance.info,
      'entities': instance.entities,
    };
