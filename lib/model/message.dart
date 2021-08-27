import 'package:json_annotation/json_annotation.dart';
part 'message.g.dart';

@JsonSerializable()
class MessageModel extends Object {
  final int id;
  final int userid;
  final String isreads;
  final String title;
  final String contents;
  final DateTime createtime;
  MessageModel({
    required this.id,
    required this.title,
    required this.contents,
    required this.createtime,
    required this.userid,
    required this.isreads,
  });

  factory MessageModel.fromJson(Map<String, dynamic> srcJson) =>
      _$MessageModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
