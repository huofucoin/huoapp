// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zichan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZiChanModel _$ZiChanModelFromJson(Map<String, dynamic> json) {
  return ZiChanModel(
    id: json['id'] as int,
    userid: json['userid'] as int,
    mobile: json['mobile'] as String,
    coinName: json['coinName'] as String,
    balance: (json['balance'] as num).toDouble(),
    frozens: (json['frozens'] as num).toDouble(),
    totalamount: (json['totalamount'] as num).toDouble(),
    status: json['status'] as int,
    lockp: (json['lockp'] as num?)?.toDouble() ?? 0,
    balancemoney: (json['balancemoney'] as num?)?.toDouble() ?? 0,
    frozensmoney: (json['frozensmoney'] as num?)?.toDouble() ?? 0,
    totalamountmoney: (json['totalamountmoney'] as num?)?.toDouble() ?? 0,
    lockpmoney: (json['lockpmoney'] as num?)?.toDouble() ?? 0,
  );
}

Map<String, dynamic> _$ZiChanModelToJson(ZiChanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userid': instance.userid,
      'mobile': instance.mobile,
      'coinName': instance.coinName,
      'balance': instance.balance,
      'frozens': instance.frozens,
      'totalamount': instance.totalamount,
      'status': instance.status,
      'lockp': instance.lockp,
      'balancemoney': instance.balancemoney,
      'frozensmoney': instance.frozensmoney,
      'totalamountmoney': instance.totalamountmoney,
      'lockpmoney': instance.lockpmoney,
    };
