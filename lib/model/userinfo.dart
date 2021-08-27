import 'package:json_annotation/json_annotation.dart';
part 'userinfo.g.dart';

@JsonSerializable()
class UserInfoModel extends Object {
  final int userId;
  @JsonKey(defaultValue: '')
  final String username;
  @JsonKey(defaultValue: '')
  final String mobile;
  @JsonKey(defaultValue: '')
  final String emails;
  final DateTime createTime;
  final String codes;
  @JsonKey(defaultValue: '')
  final String parentcodes;
  final int checks;
  final int shiming;
  @JsonKey(defaultValue: 0)
  final int level;
  @JsonKey(defaultValue: '')
  final String datas;
  final int conut;
  @JsonKey(defaultValue: 0)
  final int type;
  @JsonKey(defaultValue: 0)
  final double money;
  UserInfoModel({
    required this.userId,
    required this.username,
    required this.mobile,
    required this.emails,
    required this.createTime,
    required this.codes,
    required this.parentcodes,
    required this.checks,
    required this.shiming,
    required this.level,
    required this.datas,
    required this.conut,
    required this.type,
    required this.money,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> srcJson) =>
      _$UserInfoModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
}
