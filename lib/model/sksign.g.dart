// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sksign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SKSignModel _$SKSignModelFromJson(Map<String, dynamic> json) {
  return SKSignModel(
    bank: json['bank'] as String,
    weixin: json['weixin'] as String,
    zfb: json['zfb'] as String,
  );
}

Map<String, dynamic> _$SKSignModelToJson(SKSignModel instance) =>
    <String, dynamic>{
      'bank': instance.bank,
      'weixin': instance.weixin,
      'zfb': instance.zfb,
    };
