// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Auth1Model _$Auth1ModelFromJson(Map<String, dynamic> json) {
  return Auth1Model(
    id: json['id'] as int,
    userid: json['userid'] as int,
    mobile: json['mobile'] as String,
    frontimage: json['frontimage'] as String? ?? '',
    backimage: json['backimage'] as String? ?? '',
    cardnumber: json['cardnumber'] as String? ?? '',
    username: json['username'] as String? ?? '',
    bankname: json['bankname'] as String? ?? '',
    fetchbank: json['fetchbank'] as String? ?? '',
    images: json['images'] as String? ?? '',
    numbers: json['numbers'] as String? ?? '',
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$Auth1ModelToJson(Auth1Model instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'mobile': instance.mobile,
      'username': instance.username,
      'frontimage': instance.frontimage,
      'backimage': instance.backimage,
      'cardnumber': instance.cardnumber,
      'bankname': instance.bankname,
      'fetchbank': instance.fetchbank,
      'images': instance.images,
      'numbers': instance.numbers,
      'status': instance.status,
    };
