import 'package:json_annotation/json_annotation.dart';
part 'profit.g.dart';

@JsonSerializable()
class ProfitModel extends Object {
  final double profit;
  ProfitModel({required this.profit});

  factory ProfitModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ProfitModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ProfitModelToJson(this);
}
