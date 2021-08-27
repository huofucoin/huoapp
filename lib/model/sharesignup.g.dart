// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharesignup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareSignupModel _$ShareSignupModelFromJson(Map<String, dynamic> json) {
  return ShareSignupModel(
    id: json['id'] as int,
    userid: json['userid'] as int,
    mobile: json['mobile'] as String? ?? '',
    title: json['title'] as String,
    money: (json['money'] as num).toDouble(),
    chemical: json['chemical'] as String,
    coinname: json['coinname'] as String,
    createtime: DateTime.parse(json['createtime'] as String),
    type: json['type'] as int,
    suserid: json['suserid'] as int,
  );
}

Map<String, dynamic> _$ShareSignupModelToJson(ShareSignupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'mobile': instance.mobile,
      'title': instance.title,
      'money': instance.money,
      'chemical': instance.chemical,
      'coinname': instance.coinname,
      'createtime': instance.createtime.toIso8601String(),
      'type': instance.type,
      'suserid': instance.suserid,
    };
