// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'chat_bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatState _$ChatStateFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ChatState',
      json,
      ($checkedConvert) {
        final val = ChatState(
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$ChatStatusEnumMap, v) ??
                  ChatStatus.initial),
          messages: $checkedConvert(
              'messages',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          ChatMessage.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
    );

Map<String, dynamic> _$ChatStateToJson(ChatState instance) => <String, dynamic>{
      'status': _$ChatStatusEnumMap[instance.status],
      'messages': instance.messages,
    };

const _$ChatStatusEnumMap = {
  ChatStatus.initial: 'initial',
  ChatStatus.loading: 'loading',
  ChatStatus.success: 'success',
  ChatStatus.failure: 'failure',
};
