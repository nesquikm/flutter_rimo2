// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'episode_info_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodeInfoState _$EpisodeInfoStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'EpisodeInfoState',
      json,
      ($checkedConvert) {
        final val = EpisodeInfoState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$EpisodeInfoStatusEnumMap, v) ??
                  EpisodeInfoStatus.initial),
          episodeCache: $checkedConvert(
              'episode_cache',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(int.parse(k),
                        Episode.fromJson(e as Map<String, dynamic>)),
                  ) ??
                  const <int, Episode>{}),
          episode: $checkedConvert(
              'episode',
              (v) => v == null
                  ? null
                  : Episode.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'episodeCache': 'episode_cache'},
    );

Map<String, dynamic> _$EpisodeInfoStateToJson(EpisodeInfoState instance) =>
    <String, dynamic>{
      'status': _$EpisodeInfoStatusEnumMap[instance.status],
      'episode_cache':
          instance.episodeCache.map((k, e) => MapEntry(k.toString(), e)),
      'episode': instance.episode,
    };

const _$EpisodeInfoStatusEnumMap = {
  EpisodeInfoStatus.initial: 'initial',
  EpisodeInfoStatus.loading: 'loading',
  EpisodeInfoStatus.success: 'success',
  EpisodeInfoStatus.failure: 'failure',
};
