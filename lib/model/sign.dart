import 'package:json_annotation/json_annotation.dart';
part 'sign.g.dart';

@JsonSerializable()
class SignModel extends Object {
  final int id;
  final int userid;
  final DateTime createtime;
  @JsonKey(defaultValue: 0)
  final double money;
  SignModel({
    required this.id,
    required this.userid,
    required this.createtime,
    required this.money,
  });

  factory SignModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SignModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$SignModelToJson(this);
}
