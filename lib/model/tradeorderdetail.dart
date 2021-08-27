import 'package:huofu/model/tradechengjiao.dart';
import 'package:huofu/model/tradeorder.dart';
import 'package:json_annotation/json_annotation.dart';
part 'tradeorderdetail.g.dart';

@JsonSerializable()
class TradeOrderDetailModel extends Object {
  final String id;
  final String token;
  final List<TradeChengjiaoModel> list;
  final TradeOrderModel transbillEntity;
  TradeOrderDetailModel({
    required this.id,
    required this.token,
    required this.list,
    required this.transbillEntity,
  });

  factory TradeOrderDetailModel.fromJson(Map<String, dynamic> srcJson) =>
      _$TradeOrderDetailModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$TradeOrderDetailModelToJson(this);
}
