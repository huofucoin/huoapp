import 'package:json_annotation/json_annotation.dart';
part 'sksign.g.dart';

@JsonSerializable()
class SKSignModel extends Object {
  final String bank;
  final String weixin;
  final String zfb;
  SKSignModel({
    required this.bank,
    required this.weixin,
    required this.zfb,
  });

  factory SKSignModel.fromJson(Map<String, dynamic> srcJson) =>
      _$SKSignModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$SKSignModelToJson(this);
}
