// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionModel _$VersionModelFromJson(Map<String, dynamic> json) {
  return VersionModel(
    id: json['id'] as int,
    apptype: json['apptype'] as int,
    vername: json['vername'] as String,
    vercode: json['vercode'] as String,
    createtime: DateTime.parse(json['createtime'] as String),
    contents: json['contents'] as String? ?? '',
    appurl: json['appurl'] as String? ?? '',
    isforce: json['isforce'] as int,
  );
}

Map<String, dynamic> _$VersionModelToJson(VersionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'apptype': instance.apptype,
      'vername': instance.vername,
      'vercode': instance.vercode,
      'contents': instance.contents,
      'appurl': instance.appurl,
      'createtime': instance.createtime.toIso8601String(),
      'isforce': instance.isforce,
    };
