// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Chat _$$_ChatFromJson(Map<String, dynamic> json) => _$_Chat(
      conversationId: json['conversationId'] as String?,
      doctorId: json['doctorId'] as String?,
      patientId: json['patientId'] as String?,
    );

Map<String, dynamic> _$$_ChatToJson(_$_Chat instance) => <String, dynamic>{
      'conversationId': instance.conversationId,
      'doctorId': instance.doctorId,
      'patientId': instance.patientId,
    };

_$_Message _$$_MessageFromJson(Map<String, dynamic> json) => _$_Message(
      senderId: json['senderId'] as String?,
      content: json['content'] as String?,
      dateTime: json['dateTime'] as String?,
    );

Map<String, dynamic> _$$_MessageToJson(_$_Message instance) =>
    <String, dynamic>{
      'senderId': instance.senderId,
      'content': instance.content,
      'dateTime': instance.dateTime,
    };
