import 'package:json_annotation/json_annotation.dart';
part 'sharesignup.g.dart';

@JsonSerializable()
class ShareSignupModel extends Object {
  final int id;
  final int userid;
  @JsonKey(defaultValue: '')
  final String mobile;
  final String title;
  final double money;
  final String chemical;
  final String coinname;
  final DateTime createtime;
  final int type;
  final int suserid;
  ShareSignupModel({
    required this.id,
    required this.userid,
    required this.mobile,
    required this.title,
    required this.money,
    required this.chemical,
    required this.coinname,
    required this.createtime,
    required this.type,
    required this.suserid,
  });

  factory ShareSignupModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ShareSignupModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ShareSignupModelToJson(this);
}
