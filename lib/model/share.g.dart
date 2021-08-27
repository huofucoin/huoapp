// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareModel _$ShareModelFromJson(Map<String, dynamic> json) {
  return ShareModel(
    fcount: json['fcount'] as int,
    fmoney: (json['fmoney'] as num).toDouble(),
    tmoney: (json['tmoney'] as num).toDouble(),
    smoney: (json['smoney'] as num).toDouble(),
  );
}

Map<String, dynamic> _$ShareModelToJson(ShareModel instance) =>
    <String, dynamic>{
      'fcount': instance.fcount,
      'fmoney': instance.fmoney,
      'tmoney': instance.tmoney,
      'smoney': instance.smoney,
    };
