import 'package:json_annotation/json_annotation.dart';
part 'banner.g.dart';

@JsonSerializable()
class BannerModel extends Object {
  final int id;
  final String urls;
  BannerModel({
    required this.id,
    required this.urls,
  });

  factory BannerModel.fromJson(Map<String, dynamic> srcJson) =>
      _$BannerModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
