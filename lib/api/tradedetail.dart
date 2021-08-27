import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/tradeorderdetail.dart';

Future<ResponseModel<TradeOrderDetailModel>> tradedetail(int id) async {
  Response response =
      await iDio().post('/api/wtdetail', queryParameters: {'id': id});
  return ResponseModel.fromJson(
      response.data, (json) => TradeOrderDetailModel.fromJson(json));
}
