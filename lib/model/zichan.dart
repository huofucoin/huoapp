import 'package:json_annotation/json_annotation.dart';
part 'zichan.g.dart';

@JsonSerializable()
class ZiChanModel extends Object {
  final int id;
  final int userid;
  final String mobile;
  final String coinName;
  final double balance;
  final double frozens;
  final double totalamount;
  final int status;
  @JsonKey(defaultValue: 0)
  final double lockp;
  @JsonKey(defaultValue: 0)
  final double balancemoney;
  @JsonKey(defaultValue: 0)
  final double frozensmoney;
  @JsonKey(defaultValue: 0)
  final double totalamountmoney;
  @JsonKey(defaultValue: 0)
  final double lockpmoney;
  ZiChanModel({
    required this.id,
    required this.userid,
    required this.mobile,
    required this.coinName,
    required this.balance,
    required this.frozens,
    required this.totalamount,
    required this.status,
    required this.lockp,
    required this.balancemoney,
    required this.frozensmoney,
    required this.totalamountmoney,
    required this.lockpmoney,
  });

  factory ZiChanModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ZiChanModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ZiChanModelToJson(this);
}
