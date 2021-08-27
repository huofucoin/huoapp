// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderpre.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPreModel _$OrderPreModelFromJson(Map<String, dynamic> json) {
  return OrderPreModel(
    id: json['id'] as int,
    username: json['username'] as String,
    bankname: json['bankname'] as String?,
    batchbank: json['batchbank'] as String?,
    cardnumber: json['cardnumber'] as String?,
    wimage: json['wimage'] as String?,
    wnumbers: json['wnumbers'] as String?,
    znumbers: json['znumbers'] as String?,
    zimages: json['zimages'] as String?,
  );
}

Map<String, dynamic> _$OrderPreModelToJson(OrderPreModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'bankname': instance.bankname,
      'batchbank': instance.batchbank,
      'cardnumber': instance.cardnumber,
      'wimage': instance.wimage,
      'wnumbers': instance.wnumbers,
      'zimages': instance.zimages,
      'znumbers': instance.znumbers,
    };
