import 'package:json_annotation/json_annotation.dart';
part 'jiaocang.g.dart';

@JsonSerializable()
class JiaoCangModel extends Object {
  final double coinnumber;
  final int days;
  final int id;
  final int maxcount;
  final double rates;
  final int scount;
  final int smallcount;
  final int status;
  final double sxf;
  final int tcount;
  final DateTime createtime;
  final DateTime endtime;
  final DateTime starttime;
  final String productname;
  final String orgtions;
  final String name;
  JiaoCangModel({
    required this.id,
    required this.coinnumber,
    required this.days,
    required this.createtime,
    required this.maxcount,
    required this.rates,
    required this.scount,
    required this.smallcount,
    required this.status,
    required this.sxf,
    required this.tcount,
    required this.endtime,
    required this.starttime,
    required this.productname,
    required this.orgtions,
    required this.name,
  });

  factory JiaoCangModel.fromJson(Map<String, dynamic> srcJson) =>
      _$JiaoCangModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$JiaoCangModelToJson(this);
}
