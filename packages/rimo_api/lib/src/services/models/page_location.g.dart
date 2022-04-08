// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'page_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageLocation _$PageLocationFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PageLocation',
      json,
      ($checkedConvert) {
        final val = PageLocation(
          info: $checkedConvert(
              'info', (v) => Info.fromJson(v as Map<String, dynamic>)),
          entities: $checkedConvert(
              'entities',
              (v) => (v as List<dynamic>)
                  .map((e) => Location.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PageLocationToJson(PageLocation instance) =>
    <String, dynamic>{
      'info': instance.info,
      'entities': instance.entities,
    };
