// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpModel _$HelpModelFromJson(Map<String, dynamic> json) {
  return HelpModel(
    id: json['id'] as int,
    name: json['name'] as String,
    images: json['images'] as String,
    ishome: json['ishome'] as int? ?? 0,
    numbers: json['numbers'] as int,
    articles: (json['articles'] as List<dynamic>)
        .map((e) => ArticleModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HelpModelToJson(HelpModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'images': instance.images,
      'ishome': instance.ishome,
      'numbers': instance.numbers,
      'articles': instance.articles,
    };

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel(
    id: json['id'] as int,
    contents: json['contents'] as String,
    images: json['images'] as String? ?? '',
    title: json['title'] as String,
    type: json['type'] as int,
    createtime: DateTime.parse(json['createtime'] as String),
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contents': instance.contents,
      'images': instance.images,
      'title': instance.title,
      'type': instance.type,
      'createtime': instance.createtime.toIso8601String(),
    };
