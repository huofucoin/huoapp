import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/tradeorder.dart';

Future<ResponseModel<TradeOrderModel>> tradeordernow(int page,
    {int? billtype}) async {
  Map<String, dynamic> query = {'page': page, 'limit': 10};
  if (billtype != null) {
    query['billtype'] = billtype;
  }
  Response response =
      await iDio().post('/api/nowwtorder', queryParameters: query);
  return ResponseModel.fromJson(
      response.data, (json) => TradeOrderModel.fromJson(json));
}
