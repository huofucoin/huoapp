// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return OrderModel(
    id: json['id'] as int,
    userid: json['userid'] as int,
    username: json['username'] as String,
    buyname: json['buyname'] as String? ?? '',
    bankname: json['bankname'] as String?,
    batchbank: json['batchbank'] as String?,
    cardnumber: json['cardnumber'] as String?,
    numbers: json['numbers'] as String?,
    images: json['images'] as String?,
    count: (json['count'] as num).toDouble(),
    money: (json['money'] as num).toDouble(),
    ordernumber: json['ordernumber'] as String,
    paytype: json['paytype'] as int,
    ordertype: json['ordertype'] as int,
    status: json['status'] as int? ?? 0,
    unitmoney: (json['unitmoney'] as num).toDouble(),
    createtime: DateTime.parse(json['createtime'] as String),
    sxfmoney: (json['sxfmoney'] as num).toDouble(),
    managerid: json['managerid'] as int? ?? 0,
    cancletime: json['cancletime'] == null
        ? null
        : DateTime.parse(json['cancletime'] as String),
    successtime: json['successtime'] == null
        ? null
        : DateTime.parse(json['successtime'] as String),
    paytime: json['paytime'] == null
        ? null
        : DateTime.parse(json['paytime'] as String),
  );
}

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'username': instance.username,
      'bankname': instance.bankname,
      'batchbank': instance.batchbank,
      'cardnumber': instance.cardnumber,
      'images': instance.images,
      'buyname': instance.buyname,
      'numbers': instance.numbers,
      'count': instance.count,
      'money': instance.money,
      'ordernumber': instance.ordernumber,
      'paytype': instance.paytype,
      'ordertype': instance.ordertype,
      'status': instance.status,
      'unitmoney': instance.unitmoney,
      'sxfmoney': instance.sxfmoney,
      'managerid': instance.managerid,
      'createtime': instance.createtime.toIso8601String(),
      'cancletime': instance.cancletime?.toIso8601String(),
      'successtime': instance.successtime?.toIso8601String(),
      'paytime': instance.paytime?.toIso8601String(),
    };
