import 'package:json_annotation/json_annotation.dart';
part 'version.g.dart';

@JsonSerializable()
class VersionModel extends Object {
  final int id;
  final int apptype;
  final String vername;
  final String vercode;
  @JsonKey(defaultValue: '')
  final String contents;
  @JsonKey(defaultValue: '')
  final String appurl;
  final DateTime createtime;
  final int isforce;
  VersionModel({
    required this.id,
    required this.apptype,
    required this.vername,
    required this.vercode,
    required this.createtime,
    required this.contents,
    required this.appurl,
    required this.isforce,
  });

  factory VersionModel.fromJson(Map<String, dynamic> srcJson) =>
      _$VersionModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$VersionModelToJson(this);
}
