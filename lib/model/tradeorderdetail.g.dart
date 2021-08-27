// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tradeorderdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TradeOrderDetailModel _$TradeOrderDetailModelFromJson(
    Map<String, dynamic> json) {
  return TradeOrderDetailModel(
    id: json['id'] as String,
    token: json['token'] as String,
    list: (json['list'] as List<dynamic>)
        .map((e) => TradeChengjiaoModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    transbillEntity: TradeOrderModel.fromJson(
        json['transbillEntity'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TradeOrderDetailModelToJson(
        TradeOrderDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'list': instance.list,
      'transbillEntity': instance.transbillEntity,
    };
