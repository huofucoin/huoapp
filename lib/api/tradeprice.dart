import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/tradeprice.dart';

Future<ResponseModel<TradePriceModel>> tradeprice() async {
  Response response = await iDio().post('/api/price');
  return ResponseModel.fromJson(
      response.data, (json) => TradePriceModel.fromJson(json['data'] ?? json));
}
