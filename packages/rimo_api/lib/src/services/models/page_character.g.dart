// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'page_character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageCharacter _$PageCharacterFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'PageCharacter',
      json,
      ($checkedConvert) {
        final val = PageCharacter(
          info: $checkedConvert(
              'info', (v) => Info.fromJson(v as Map<String, dynamic>)),
          entities: $checkedConvert(
              'entities',
              (v) => (v as List<dynamic>)
                  .map((e) => Character.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$PageCharacterToJson(PageCharacter instance) =>
    <String, dynamic>{
      'info': instance.info,
      'entities': instance.entities,
    };
