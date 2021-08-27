// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) {
  return AnnouncementModel(
    id: json['id'] as int,
    title: json['title'] as String,
    contents: json['contents'] as String,
    createtime: DateTime.parse(json['createtime'] as String),
  );
}

Map<String, dynamic> _$AnnouncementModelToJson(AnnouncementModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'contents': instance.contents,
      'createtime': instance.createtime.toIso8601String(),
    };
