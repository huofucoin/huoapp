import 'package:json_annotation/json_annotation.dart';
part 'response.g.dart';

@JsonSerializable()
class ResponseModel<T> extends Object {
  final int code;
  @JsonKey(defaultValue: '')
  final String msg;
  final String? zjpassword;
  final T? data;
  final T? version;
  final List<T>? list;
  final T? sign;
  final T? weixin;
  final T? zfb;
  final T? bank;
  final T? user;
  final double? nowprice;
  final String? updown;
  final String? token;
  ResponseModel({
    required this.code,
    required this.msg,
    this.data,
    this.version,
    this.list,
    this.sign,
    this.zjpassword,
    this.weixin,
    this.zfb,
    this.bank,
    this.nowprice,
    this.updown,
    this.token,
    this.user,
  });

  factory ResponseModel.fromJson(
          Map<String, dynamic> srcJson, T Function(dynamic json) fromJsonT) =>
      _$ResponseModelFromJson(srcJson, fromJsonT);
  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) =>
      _$ResponseModelToJson(this, toJsonT);
}
