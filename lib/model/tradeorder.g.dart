// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradeorder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeOrderModel _$TradeOrderModelFromJson(Map<String, dynamic> json) {
  return TradeOrderModel(
    id: json['id'] as int,
    currencyId: json['currencyId'] as int,
    billPrice: (json['billPrice'] as num).toDouble(),
    billQuantity: (json['billQuantity'] as num).toDouble(),
    billQuantityCopy: (json['billQuantityCopy'] as num).toDouble(),
    avamoney: (json['avamoney'] as num?)?.toDouble() ?? 0,
    createTime: json['createTime'] as int,
    relativeCurrencyId: json['relativeCurrencyId'] as int,
    billType: json['billType'] as int,
    userId: json['userId'] as int,
    deleted: json['deleted'] as int,
    sxfmoney: (json['sxfmoney'] as num?)?.toDouble() ?? 0,
    revoked: json['revoked'] as int,
  );
}

Map<String, dynamic> _$TradeOrderModelToJson(TradeOrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currencyId': instance.currencyId,
      'billPrice': instance.billPrice,
      'billQuantity': instance.billQuantity,
      'billQuantityCopy': instance.billQuantityCopy,
      'avamoney': instance.avamoney,
      'createTime': instance.createTime,
      'relativeCurrencyId': instance.relativeCurrencyId,
      'billType': instance.billType,
      'userId': instance.userId,
      'deleted': instance.deleted,
      'revoked': instance.revoked,
      'sxfmoney': instance.sxfmoney,
    };
