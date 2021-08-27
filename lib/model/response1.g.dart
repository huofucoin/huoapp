// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response1.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return ResponseModel<T>(
    code: json['code'] as int,
    msg: json['msg'] as String,
    data: (json['data'] as List<dynamic>?)?.map(fromJsonT).toList(),
    totalcount: json['totalcount'] as int?,
    zcount: json['zcount'] as int?,
    jcount: json['jcount'] as int?,
    count: json['count'] as int?,
    tlmoney: (json['tlmoney'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$ResponseModelToJson<T>(
  ResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data?.map(toJsonT).toList(),
      'totalcount': instance.totalcount,
      'zcount': instance.zcount,
      'jcount': instance.jcount,
      'count': instance.count,
      'tlmoney': instance.tlmoney,
    };
