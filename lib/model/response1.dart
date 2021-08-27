import 'package:json_annotation/json_annotation.dart';
part 'response1.g.dart';

@JsonSerializable()
class ResponseModel<T> extends Object {
  final int code;
  final String msg;
  final List<T>? data;
  final int? totalcount;
  final int? zcount;
  final int? jcount;
  final int? count;
  @JsonKey(defaultValue: 0)
  final double? tlmoney;
  ResponseModel({
    required this.code,
    required this.msg,
    this.data,
    this.totalcount,
    this.zcount,
    this.jcount,
    this.count,
    this.tlmoney,
  });

  factory ResponseModel.fromJson(
          Map<String, dynamic> srcJson, T Function(dynamic json) fromJsonT) =>
      _$ResponseModelFromJson(srcJson, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ResponseModelToJson(this, toJsonT);
}
