// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BillModel _$BillModelFromJson(Map<String, dynamic> json) {
  return BillModel(
    id: json['id'] as int,
    userid: json['userid'] as int,
    type: json['type'] as int,
    title: json['title'] as String,
    orderid: json['orderid'] as int? ?? 0,
    money: (json['money'] as num).toDouble(),
    chemical: json['chemical'] as String,
    createtime: DateTime.parse(json['createtime'] as String),
    coinname: json['coinname'] as String,
  );
}

Map<String, dynamic> _$BillModelToJson(BillModel instance) => <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'type': instance.type,
      'title': instance.title,
      'orderid': instance.orderid,
      'money': instance.money,
      'chemical': instance.chemical,
      'coinname': instance.coinname,
      'createtime': instance.createtime.toIso8601String(),
    };
