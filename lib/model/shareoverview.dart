import 'package:json_annotation/json_annotation.dart';
part 'shareoverview.g.dart';

@JsonSerializable()
class ShareOverviewModel extends Object {
  final int userId;
  @JsonKey(defaultValue: '')
  final String username;
  final String mobile;
  final String emails;
  @JsonKey(defaultValue: '')
  final String avatar;
  final DateTime createTime;
  final String codes;
  final String parentcodes;
  final int checks;
  final int shiming;
  final int level;
  @JsonKey(defaultValue: '')
  final String datas;
  final int conut;
  @JsonKey(defaultValue: 0)
  final int type;
  @JsonKey(defaultValue: 0)
  final double money;
  final int status;
  ShareOverviewModel({
    required this.userId,
    required this.username,
    required this.mobile,
    required this.emails,
    required this.avatar,
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
    required this.status,
  });

  factory ShareOverviewModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ShareOverviewModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ShareOverviewModelToJson(this);
}
