// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageEntity _$$_MessageEntityFromJson(Map<String, dynamic> json) =>
    _$_MessageEntity(
      prompt: json['prompt'] as String,
      status: json['status'] == null
          ? null
          : MessageStatus.fromJson(json['status'] as Map<String, dynamic>),
      response: json['response'] as String? ?? "",
      parentMessageId: json['parentMessageId'] as String? ?? "",
    );

Map<String, dynamic> _$$_MessageEntityToJson(_$_MessageEntity instance) =>
    <String, dynamic>{
      'prompt': instance.prompt,
      'status': instance.status,
      'response': instance.response,
      'parentMessageId': instance.parentMessageId,
    };
