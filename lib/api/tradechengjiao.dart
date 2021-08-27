import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/tradechengjiao.dart';

Future<ResponseModel<TradeChengjiaoModel>> tradechengjiao() async {
  Response response = await iDio().post('/api/kchengjorder');
  return ResponseModel.fromJson(
      response.data, (json) => TradeChengjiaoModel.fromJson(json));
}
