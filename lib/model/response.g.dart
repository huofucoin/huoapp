// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResponseModel<T> _$ResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) {
  return ResponseModel<T>(
    code: json['code'] as int,
    msg: json['msg'] as String? ?? '',
    data: _$nullableGenericFromJson(json['data'], fromJsonT),
    version: _$nullableGenericFromJson(json['version'], fromJsonT),
    list: (json['list'] as List<dynamic>?)?.map(fromJsonT).toList(),
    sign: _$nullableGenericFromJson(json['sign'], fromJsonT),
    zjpassword: json['zjpassword'] as String?,
    weixin: _$nullableGenericFromJson(json['weixin'], fromJsonT),
    zfb: _$nullableGenericFromJson(json['zfb'], fromJsonT),
    bank: _$nullableGenericFromJson(json['bank'], fromJsonT),
    nowprice: (json['nowprice'] as num?)?.toDouble(),
    updown: json['updown'] as String?,
    token: json['token'] as String?,
    user: _$nullableGenericFromJson(json['user'], fromJsonT),
  );
}

Map<String, dynamic> _$ResponseModelToJson<T>(
  ResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'zjpassword': instance.zjpassword,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'version': _$nullableGenericToJson(instance.version, toJsonT),
      'list': instance.list?.map(toJsonT).toList(),
      'sign': _$nullableGenericToJson(instance.sign, toJsonT),
      'weixin': _$nullableGenericToJson(instance.weixin, toJsonT),
      'zfb': _$nullableGenericToJson(instance.zfb, toJsonT),
      'bank': _$nullableGenericToJson(instance.bank, toJsonT),
      'user': _$nullableGenericToJson(instance.user, toJsonT),
      'nowprice': instance.nowprice,
      'updown': instance.updown,
      'token': instance.token,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
