// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    userId: json['userId'] as int,
    username: json['username'] as String? ?? '',
    mobile: json['mobile'] as String? ?? '',
    emails: json['emails'] as String? ?? '',
    createTime: DateTime.parse(json['createTime'] as String),
    codes: json['codes'] as String,
    parentcodes: json['parentcodes'] as String? ?? '',
    checks: json['checks'] as int,
    shiming: json['shiming'] as int,
    level: json['level'] as int? ?? 0,
    datas: json['datas'] as String? ?? '',
    conut: json['conut'] as int,
    type: json['type'] as int? ?? 0,
    money: (json['money'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'mobile': instance.mobile,
      'emails': instance.emails,
      'createTime': instance.createTime.toIso8601String(),
      'codes': instance.codes,
      'parentcodes': instance.parentcodes,
      'checks': instance.checks,
      'shiming': instance.shiming,
      'level': instance.level,
      'datas': instance.datas,
      'conut': instance.conut,
      'type': instance.type,
      'money': instance.money,
    };
