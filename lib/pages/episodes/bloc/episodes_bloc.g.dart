// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'episodes_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EpisodesState _$EpisodesStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'EpisodesState',
      json,
      ($checkedConvert) {
        final val = EpisodesState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$EpisodesStatusEnumMap, v) ??
                  EpisodesStatus.initial),
          episodes: $checkedConvert(
              'episodes',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const <Episode>[]),
          lastPage: $checkedConvert(
              'last_page',
              (v) => v == null
                  ? null
                  : PageEpisode.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'lastPage': 'last_page'},
    );

Map<String, dynamic> _$EpisodesStateToJson(EpisodesState instance) =>
    <String, dynamic>{
      'last_page': instance.lastPage,
      'status': _$EpisodesStatusEnumMap[instance.status],
      'episodes': instance.episodes,
    };

const _$EpisodesStatusEnumMap = {
  EpisodesStatus.initial: 'initial',
  EpisodesStatus.loading: 'loading',
  EpisodesStatus.success: 'success',
  EpisodesStatus.failure: 'failure',
};
