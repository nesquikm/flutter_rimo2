// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'locations_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationsState _$LocationsStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'LocationsState',
      json,
      ($checkedConvert) {
        final val = LocationsState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$LocationsStatusEnumMap, v) ??
                  LocationsStatus.initial),
          locations: $checkedConvert(
              'locations',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Location.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const <Location>[]),
          lastPage: $checkedConvert(
              'last_page',
              (v) => v == null
                  ? null
                  : PageLocation.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'lastPage': 'last_page'},
    );

Map<String, dynamic> _$LocationsStateToJson(LocationsState instance) =>
    <String, dynamic>{
      'last_page': instance.lastPage,
      'status': _$LocationsStatusEnumMap[instance.status],
      'locations': instance.locations,
    };

const _$LocationsStatusEnumMap = {
  LocationsStatus.initial: 'initial',
  LocationsStatus.loading: 'loading',
  LocationsStatus.success: 'success',
  LocationsStatus.failure: 'failure',
};
