// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'characters_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharactersState _$CharactersStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CharactersState',
      json,
      ($checkedConvert) {
        final val = CharactersState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$CharactersStatusEnumMap, v) ??
                  CharactersStatus.initial),
          characters: $checkedConvert(
              'characters',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map(
                          (e) => Character.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const <Character>[]),
          lastPage: $checkedConvert(
              'last_page',
              (v) => v == null
                  ? null
                  : PageCharacter.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'lastPage': 'last_page'},
    );

Map<String, dynamic> _$CharactersStateToJson(CharactersState instance) =>
    <String, dynamic>{
      'last_page': instance.lastPage,
      'status': _$CharactersStatusEnumMap[instance.status],
      'characters': instance.characters,
    };

const _$CharactersStatusEnumMap = {
  CharactersStatus.initial: 'initial',
  CharactersStatus.loading: 'loading',
  CharactersStatus.success: 'success',
  CharactersStatus.failure: 'failure',
};
