import 'package:json_annotation/json_annotation.dart';
part 'order.g.dart';

@JsonSerializable()
class OrderModel extends Object {
  final int id;
  final int userid;
  final String username;
  final String? bankname;
  final String? batchbank;
  final String? cardnumber;
  final String? images;
  @JsonKey(defaultValue: '')
  final String buyname;
  final String? numbers;
  final double count;
  final double money;
  final String ordernumber;
  final int paytype;
  final int ordertype;
  @JsonKey(defaultValue: 0)
  final int status;
  final double unitmoney;
  final double sxfmoney;
  @JsonKey(defaultValue: 0)
  final int managerid;
  final DateTime createtime;
  final DateTime? cancletime;
  final DateTime? successtime;
  final DateTime? paytime;
  OrderModel({
    required this.id,
    required this.userid,
    required this.username,
    required this.buyname,
    this.bankname,
    this.batchbank,
    this.cardnumber,
    this.numbers,
    this.images,
    required this.count,
    required this.money,
    required this.ordernumber,
    required this.paytype,
    required this.ordertype,
    required this.status,
    required this.unitmoney,
    required this.createtime,
    required this.sxfmoney,
    required this.managerid,
    this.cancletime,
    this.successtime,
    this.paytime,
  });

  factory OrderModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
