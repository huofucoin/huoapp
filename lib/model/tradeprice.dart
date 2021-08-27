import 'package:json_annotation/json_annotation.dart';
part 'tradeprice.g.dart';

@JsonSerializable()
class TradePriceModel extends Object {
  final Map<String, String> pricein;
  final Map<String, String> priceout;
  final String newprice;
  TradePriceModel({
    required this.newprice,
    required this.pricein,
    required this.priceout,
  });

  factory TradePriceModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TradePriceModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$TradePriceModelToJson(this);
}
