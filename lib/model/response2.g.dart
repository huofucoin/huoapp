// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response2.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel _$ResponseModelFromJson(Map<String, dynamic> json) {
  return ResponseModel(
    code: json['code'] as int,
    msg: json['msg'] as String,
    count: json['count'] as int? ?? 0,
  );
}

Map<String, dynamic> _$ResponseModelToJson(ResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'count': instance.count,
    };
