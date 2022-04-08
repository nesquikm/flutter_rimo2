// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Episode',
      json,
      ($checkedConvert) {
        final val = Episode(
          id: $checkedConvert('id', (v) => v as int),
          name: $checkedConvert('name', (v) => v as String),
          airDate: $checkedConvert('air_date', (v) => v as String),
          episode: $checkedConvert('episode', (v) => v as String),
          characters: $checkedConvert('characters',
              (v) => (v as List<dynamic>).map((e) => e as String).toList()),
          url: $checkedConvert('url', (v) => v as String),
          created:
              $checkedConvert('created', (v) => DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {'airDate': 'air_date'},
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'air_date': instance.airDate,
      'episode': instance.episode,
      'characters': instance.characters,
      'url': instance.url,
      'created': instance.created.toIso8601String(),
    };
