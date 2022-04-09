// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'character_info_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterInfoState _$CharacterInfoStateFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'CharacterInfoState',
      json,
      ($checkedConvert) {
        final val = CharacterInfoState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$CharacterInfoStatusEnumMap, v) ??
                  CharacterInfoStatus.initial),
          characterCache: $checkedConvert(
              'character_cache',
              (v) =>
                  (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(int.parse(k),
                        Character.fromJson(e as Map<String, dynamic>)),
                  ) ??
                  const <int, Character>{}),
          character: $checkedConvert(
              'character',
              (v) => v == null
                  ? null
                  : Character.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
      fieldKeyMap: const {'characterCache': 'character_cache'},
    );

Map<String, dynamic> _$CharacterInfoStateToJson(CharacterInfoState instance) =>
    <String, dynamic>{
      'status': _$CharacterInfoStatusEnumMap[instance.status],
      'character_cache':
          instance.characterCache.map((k, e) => MapEntry(k.toString(), e)),
      'character': instance.character,
    };

const _$CharacterInfoStatusEnumMap = {
  CharacterInfoStatus.initial: 'initial',
  CharacterInfoStatus.loading: 'loading',
  CharacterInfoStatus.success: 'success',
  CharacterInfoStatus.failure: 'failure',
};
