// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradeprice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradePriceModel _$TradePriceModelFromJson(Map<String, dynamic> json) {
  return TradePriceModel(
    newprice: json['newprice'] as String,
    pricein: Map<String, String>.from(json['pricein'] as Map),
    priceout: Map<String, String>.from(json['priceout'] as Map),
  );
}

Map<String, dynamic> _$TradePriceModelToJson(TradePriceModel instance) =>
    <String, dynamic>{
      'pricein': instance.pricein,
      'priceout': instance.priceout,
      'newprice': instance.newprice,
    };
