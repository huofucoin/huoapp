// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) {
  return MessageModel(
    id: json['id'] as int,
    title: json['title'] as String,
    contents: json['contents'] as String,
    createtime: DateTime.parse(json['createtime'] as String),
    userid: json['userid'] as int,
    isreads: json['isreads'] as String,
  );
}

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'isreads': instance.isreads,
      'title': instance.title,
      'contents': instance.contents,
      'createtime': instance.createtime.toIso8601String(),
    };
