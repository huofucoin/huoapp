import 'package:json_annotation/json_annotation.dart';
part 'tradechengjiao.g.dart';

@JsonSerializable()
class TradeChengjiaoModel extends Object {
  final int id;
  final int cmcBuyer;
  final int cmcCurrencyid;
  final double cmcPrice;
  final int cmcSellyer;
  final DateTime cmcSj;
  final int cmcTrancurrencyid;
  final double cmcTransquantity;
  final int cmcBuyerTranId;
  final int cmcSellyerTranId;
  final int deleted;
  final int cmcType;
  @JsonKey(defaultValue: 0)
  final double sxfmoney;
  TradeChengjiaoModel({
    required this.id,
    required this.cmcBuyer,
    required this.cmcCurrencyid,
    required this.cmcPrice,
    required this.cmcSellyer,
    required this.cmcSj,
    required this.cmcTrancurrencyid,
    required this.cmcTransquantity,
    required this.cmcBuyerTranId,
    required this.cmcSellyerTranId,
    required this.cmcType,
    required this.deleted,
    required this.sxfmoney,
  });

  factory TradeChengjiaoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TradeChengjiaoModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$TradeChengjiaoModelToJson(this);
}
