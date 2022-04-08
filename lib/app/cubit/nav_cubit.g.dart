// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'nav_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavState _$NavStateFromJson(Map<String, dynamic> json) => $checkedCreate(
      'NavState',
      json,
      ($checkedConvert) {
        final val = NavState(
          $checkedConvert('location', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$NavStateToJson(NavState instance) => <String, dynamic>{
      'location': instance.location,
    };
