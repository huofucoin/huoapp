import 'package:json_annotation/json_annotation.dart';
part 'help.g.dart';

@JsonSerializable()
class HelpModel extends Object {
  final int id;
  final String name;
  final String images;
  @JsonKey(defaultValue: 0)
  final int ishome;
  final int numbers;
  final List<ArticleModel> articles;
  HelpModel({
    required this.id,
    required this.name,
    required this.images,
    required this.ishome,
    required this.numbers,
    required this.articles,
  });

  factory HelpModel.fromJson(Map<String, dynamic> srcJson) =>
      _$HelpModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$HelpModelToJson(this);
}

@JsonSerializable()
class ArticleModel extends Object {
  final int id;
  final String contents;
  @JsonKey(defaultValue: '')
  final String images;
  final String title;
  final int type;
  final DateTime createtime;
  ArticleModel({
    required this.id,
    required this.contents,
    required this.images,
    required this.title,
    required this.type,
    required this.createtime,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ArticleModelFromJson(srcJson);
  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}
