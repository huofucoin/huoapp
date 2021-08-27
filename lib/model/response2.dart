import 'package:json_annotation/json_annotation.dart';
part 'response2.g.dart';

@JsonSerializable()
class ResponseModel extends Object {
  final int code;
  final String msg;
  @JsonKey(defaultValue: 0)
  final int count;
  ResponseModel({
    required this.code,
    required this.msg,
    required this.count,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ResponseModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
