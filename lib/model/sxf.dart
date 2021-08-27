import 'package:json_annotation/json_annotation.dart';
part 'sxf.g.dart';

@JsonSerializable()
class SXFModel extends Object {
  final double sxf;
  SXFModel({required this.sxf});

  factory SXFModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SXFModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$SXFModelToJson(this);
}
