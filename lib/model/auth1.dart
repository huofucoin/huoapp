import 'package:json_annotation/json_annotation.dart';
part 'auth1.g.dart';

@JsonSerializable()
class Auth1Model extends Object {
  final int id;
  final int userid;
  final String mobile;

  @JsonKey(defaultValue: '')
  final String username;
  @JsonKey(defaultValue: '')
  final String frontimage;
  @JsonKey(defaultValue: '')
  final String backimage;
  // 银行卡
  @JsonKey(defaultValue: '')
  final String cardnumber; // 一级验证
  @JsonKey(defaultValue: '')
  final String bankname;
  @JsonKey(defaultValue: '')
  final String fetchbank;
  // 微信，支付宝
  @JsonKey(defaultValue: '')
  final String images; // 二级验证
  @JsonKey(defaultValue: '')
  final String numbers;
  final int status;
  Auth1Model({
    required this.id,
    required this.userid,
    required this.mobile,
    required this.frontimage,
    required this.backimage,
    required this.cardnumber,
    required this.username,
    required this.bankname,
    required this.fetchbank,
    required this.images,
    required this.numbers,
    required this.status,
  });

  factory Auth1Model.fromJson(Map<String, dynamic> srcJson) =>
      _$Auth1ModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$Auth1ModelToJson(this);
}
