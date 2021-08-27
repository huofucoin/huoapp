// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradechengjiao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeChengjiaoModel _$TradeChengjiaoModelFromJson(Map<String, dynamic> json) {
  return TradeChengjiaoModel(
    id: json['id'] as int,
    cmcBuyer: json['cmcBuyer'] as int,
    cmcCurrencyid: json['cmcCurrencyid'] as int,
    cmcPrice: (json['cmcPrice'] as num).toDouble(),
    cmcSellyer: json['cmcSellyer'] as int,
    cmcSj: DateTime.parse(json['cmcSj'] as String),
    cmcTrancurrencyid: json['cmcTrancurrencyid'] as int,
    cmcTransquantity: (json['cmcTransquantity'] as num).toDouble(),
    cmcBuyerTranId: json['cmcBuyerTranId'] as int,
    cmcSellyerTranId: json['cmcSellyerTranId'] as int,
    cmcType: json['cmcType'] as int,
    deleted: json['deleted'] as int,
    sxfmoney: (json['sxfmoney'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$TradeChengjiaoModelToJson(
        TradeChengjiaoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cmcBuyer': instance.cmcBuyer,
      'cmcCurrencyid': instance.cmcCurrencyid,
      'cmcPrice': instance.cmcPrice,
      'cmcSellyer': instance.cmcSellyer,
      'cmcSj': instance.cmcSj.toIso8601String(),
      'cmcTrancurrencyid': instance.cmcTrancurrencyid,
      'cmcTransquantity': instance.cmcTransquantity,
      'cmcBuyerTranId': instance.cmcBuyerTranId,
      'cmcSellyerTranId': instance.cmcSellyerTranId,
      'deleted': instance.deleted,
      'cmcType': instance.cmcType,
      'sxfmoney': instance.sxfmoney,
    };
