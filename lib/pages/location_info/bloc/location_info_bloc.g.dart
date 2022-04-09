// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'location_info_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationInfoState _$LocationInfoStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LocationInfoState',
      json,
      ($checkedConvert) {
        final val = LocationInfoState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$LocationInfoStatusEnumMap, v) ??
                  LocationInfoStatus.initial),
          locationCache: $checkedConvert(
              'location_cache',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(int.parse(k),
                        Location.fromJson(e as Map<String, dynamic>)),
                  ) ??
                  const <int, Location>{}),
          location: $checkedConvert(
              'location',
              (v) => v == null
                  ? null
                  : Location.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'locationCache': 'location_cache'},
    );

Map<String, dynamic> _$LocationInfoStateToJson(LocationInfoState instance) =>
    <String, dynamic>{
      'status': _$LocationInfoStatusEnumMap[instance.status],
      'location_cache':
          instance.locationCache.map((k, e) => MapEntry(k.toString(), e)),
      'location': instance.location,
    };

const _$LocationInfoStatusEnumMap = {
  LocationInfoStatus.initial: 'initial',
  LocationInfoStatus.loading: 'loading',
  LocationInfoStatus.success: 'success',
  LocationInfoStatus.failure: 'failure',
};
