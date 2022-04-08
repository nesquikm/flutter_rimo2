// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Info _$InfoFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Info',
      json,
      ($checkedConvert) {
        final val = Info(
          count: $checkedConvert('count', (v) => v as int),
          pages: $checkedConvert('pages', (v) => v as int),
          next: $checkedConvert('next', (v) => v as String?),
          prev: $checkedConvert('prev', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
      'prev': instance.prev,
    };
