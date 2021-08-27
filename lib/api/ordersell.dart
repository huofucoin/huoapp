import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<OrderModel>> ordersell(int paytype, double count) async {
  Response response = await iDio().post('/api/sellorder', queryParameters: {
    'paytype': paytype,
    'count': count.toString(),
  });
  ResponseModel<OrderModel> orderData = ResponseModel.fromJson(
      response.data, (json) => OrderModel.fromJson(json));
  return orderData;
}
