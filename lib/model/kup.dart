import 'package:json_annotation/json_annotation.dart';
part 'kup.g.dart';

@JsonSerializable()
class KupModel extends Object {
  final double volume;
  final double high;
  final double low;
  final String rate;
  final String usdprice;
  final double newprice;
  KupModel({
    required this.volume,
    required this.high,
    required this.low,
    required this.rate,
    required this.usdprice,
    required this.newprice,
  });

  factory KupModel.fromJson(Map<String, dynamic> srcJson) =>
      _$KupModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$KupModelToJson(this);
}
