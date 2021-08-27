import 'package:json_annotation/json_annotation.dart';
part 'bill.g.dart';

@JsonSerializable()
class BillModel extends Object {
  final int id;
  final int userid;
  final int type;
  final String title;
  @JsonKey(defaultValue: 0)
  final int orderid;
  final double money;
  final String chemical;
  final String coinname;
  final DateTime createtime;
  BillModel({
    required this.id,
    required this.userid,
    required this.type,
    required this.title,
    required this.orderid,
    required this.money,
    required this.chemical,
    required this.createtime,
    required this.coinname,
  });

  factory BillModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BillModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$BillModelToJson(this);
}
