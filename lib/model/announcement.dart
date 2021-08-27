import 'package:json_annotation/json_annotation.dart';
part 'announcement.g.dart';

@JsonSerializable()
class AnnouncementModel extends Object {
  final int id;
  final String title;
  final String contents;
  final DateTime createtime;
  AnnouncementModel({
    required this.id,
    required this.title,
    required this.contents,
    required this.createtime,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> srcJson) =>
      _$AnnouncementModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$AnnouncementModelToJson(this);
}
