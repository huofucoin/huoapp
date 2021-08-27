// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jiaocang.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JiaoCangModel _$JiaoCangModelFromJson(Map<String, dynamic> json) {
  return JiaoCangModel(
    id: json['id'] as int,
    coinnumber: (json['coinnumber'] as num).toDouble(),
    days: json['days'] as int,
    createtime: DateTime.parse(json['createtime'] as String),
    maxcount: json['maxcount'] as int,
    rates: (json['rates'] as num).toDouble(),
    scount: json['scount'] as int,
    smallcount: json['smallcount'] as int,
    status: json['status'] as int,
    sxf: (json['sxf'] as num).toDouble(),
    tcount: json['tcount'] as int,
    endtime: DateTime.parse(json['endtime'] as String),
    starttime: DateTime.parse(json['starttime'] as String),
    productname: json['productname'] as String,
    orgtions: json['orgtions'] as String,
    name: json['name'] as String,
  );
}

Map<String, dynamic> _$JiaoCangModelToJson(JiaoCangModel instance) =>
    <String, dynamic>{
      'coinnumber': instance.coinnumber,
      'days': instance.days,
      'id': instance.id,
      'maxcount': instance.maxcount,
      'rates': instance.rates,
      'scount': instance.scount,
      'smallcount': instance.smallcount,
      'status': instance.status,
      'sxf': instance.sxf,
      'tcount': instance.tcount,
      'createtime': instance.createtime.toIso8601String(),
      'endtime': instance.endtime.toIso8601String(),
      'starttime': instance.starttime.toIso8601String(),
      'productname': instance.productname,
      'orgtions': instance.orgtions,
      'name': instance.name,
    };
