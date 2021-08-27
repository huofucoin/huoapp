import 'package:json_annotation/json_annotation.dart';
part 'orderpre.g.dart';

@JsonSerializable()
class OrderPreModel extends Object {
  final int id;
  final String username;
  final String? bankname;
  final String? batchbank;
  final String? cardnumber;
  final String? wimage;
  final String? wnumbers;
  final String? zimages;
  final String? znumbers;
  OrderPreModel({
    required this.id,
    required this.username,
    this.bankname,
    this.batchbank,
    this.cardnumber,
    this.wimage,
    this.wnumbers,
    this.znumbers,
    this.zimages,
  });

  factory OrderPreModel.fromJson(Map<String, dynamic> srcJson) =>
      _$OrderPreModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$OrderPreModelToJson(this);
}
