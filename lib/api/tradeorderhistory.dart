import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/tradeorder.dart';

Future<ResponseModel<TradeOrderModel>> tradeorderhistory(int page,
    {int? billtype, int? leixing}) async {
  Map<String, dynamic> query = {'page': page, 'limit': 10};
  if (billtype != null) {
    query['fangxiang'] = billtype;
  } else {
    query['fangxiang'] = 0;
  }
  if (leixing != null) {
    query['leixing'] = leixing;
  } else {
    query['leixing'] = 0;
  }
  Response response =
      await iDio().post('/api/lswtorder', queryParameters: query);
  return ResponseModel.fromJson(
      response.data, (json) => TradeOrderModel.fromJson(json));
}
