// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kup.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KupModel _$KupModelFromJson(Map<String, dynamic> json) {
  return KupModel(
    volume: (json['volume'] as num).toDouble(),
    high: (json['high'] as num).toDouble(),
    low: (json['low'] as num).toDouble(),
    rate: json['rate'] as String,
    usdprice: json['usdprice'] as String,
    newprice: (json['newprice'] as num).toDouble(),
  );
}

Map<String, dynamic> _$KupModelToJson(KupModel instance) => <String, dynamic>{
      'volume': instance.volume,
      'high': instance.high,
      'low': instance.low,
      'rate': instance.rate,
      'usdprice': instance.usdprice,
      'newprice': instance.newprice,
    };
