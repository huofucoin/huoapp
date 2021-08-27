import 'package:json_annotation/json_annotation.dart';
part 'share.g.dart';

@JsonSerializable()
class ShareModel extends Object {
  final int fcount;
  final double fmoney;
  final double tmoney;
  final double smoney;
  ShareModel({
    required this.fcount,
    required this.fmoney,
    required this.tmoney,
    required this.smoney,
  });

  factory ShareModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ShareModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ShareModelToJson(this);
}
