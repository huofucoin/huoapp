import 'package:json_annotation/json_annotation.dart';
part 'wakuang.g.dart';

@JsonSerializable()
class WaKuangModel extends Object {
  final double count;
  final DateTime createtime;
  final double daypro;
  final int days;
  final DateTime endtime;
  final int id;
  final double money;
  final int pid;
  final double profit;
  final double rates;
  final DateTime starttime;
  final int status;
  final double sxf;
  @JsonKey(defaultValue: 0)
  final double sxfl;
  @JsonKey(defaultValue: 0)
  final double unitprice;
  final int userid;
  final double yprofit;
  WaKuangModel({
    required this.id,
    required this.count,
    required this.days,
    required this.createtime,
    required this.daypro,
    required this.rates,
    required this.money,
    required this.pid,
    required this.status,
    required this.sxf,
    required this.profit,
    required this.endtime,
    required this.starttime,
    required this.unitprice,
    required this.userid,
    required this.yprofit,
    required this.sxfl,
  });

  factory WaKuangModel.fromJson(Map<String, dynamic> srcJson) =>
      _$WaKuangModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$WaKuangModelToJson(this);
}
