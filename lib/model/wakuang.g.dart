// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wakuang.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WaKuangModel _$WaKuangModelFromJson(Map<String, dynamic> json) {
  return WaKuangModel(
    id: json['id'] as int,
    count: (json['count'] as num).toDouble(),
    days: json['days'] as int,
    createtime: DateTime.parse(json['createtime'] as String),
    daypro: (json['daypro'] as num).toDouble(),
    rates: (json['rates'] as num).toDouble(),
    money: (json['money'] as num).toDouble(),
    pid: json['pid'] as int,
    status: json['status'] as int,
    sxf: (json['sxf'] as num).toDouble(),
    profit: (json['profit'] as num).toDouble(),
    endtime: DateTime.parse(json['endtime'] as String),
    starttime: DateTime.parse(json['starttime'] as String),
    unitprice: (json['unitprice'] as num?)?.toDouble() ?? 0,
    userid: json['userid'] as int,
    yprofit: (json['yprofit'] as num).toDouble(),
    sxfl: (json['sxfl'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$WaKuangModelToJson(WaKuangModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'createtime': instance.createtime.toIso8601String(),
      'daypro': instance.daypro,
      'days': instance.days,
      'endtime': instance.endtime.toIso8601String(),
      'id': instance.id,
      'money': instance.money,
      'pid': instance.pid,
      'profit': instance.profit,
      'rates': instance.rates,
      'starttime': instance.starttime.toIso8601String(),
      'status': instance.status,
      'sxf': instance.sxf,
      'sxfl': instance.sxfl,
      'unitprice': instance.unitprice,
      'userid': instance.userid,
      'yprofit': instance.yprofit,
    };
