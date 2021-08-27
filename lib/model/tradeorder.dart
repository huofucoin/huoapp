import 'package:json_annotation/json_annotation.dart';
part 'tradeorder.g.dart';

@JsonSerializable()
class TradeOrderModel extends Object {
  final int id;
  final int currencyId;
  final double billPrice;
  final double billQuantity;
  final double billQuantityCopy;
  @JsonKey(defaultValue: 0)
  final double avamoney;
  final int createTime;
  final int relativeCurrencyId;
  final int billType;
  final int userId;
  final int deleted;
  final int revoked;
  @JsonKey(defaultValue: 0)
  final double sxfmoney;
  TradeOrderModel({
    required this.id,
    required this.currencyId,
    required this.billPrice,
    required this.billQuantity,
    required this.billQuantityCopy,
    required this.avamoney,
    required this.createTime,
    required this.relativeCurrencyId,
    required this.billType,
    required this.userId,
    required this.deleted,
    required this.sxfmoney,
    required this.revoked,
  });

  factory TradeOrderModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TradeOrderModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$TradeOrderModelToJson(this);
}
