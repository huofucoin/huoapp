// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignModel _$SignModelFromJson(Map<String, dynamic> json) {
  return SignModel(
    id: json['id'] as int,
    userid: json['userid'] as int,
    createtime: DateTime.parse(json['createtime'] as String),
    money: (json['money'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$SignModelToJson(SignModel instance) => <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'createtime': instance.createtime.toIso8601String(),
      'money': instance.money,
    };
