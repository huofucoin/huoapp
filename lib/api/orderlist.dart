import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<OrderModel>> orderlist(int type, int page) async {
  Response response = await iDio().post('/api/orderlist',
      queryParameters: {'type': type, 'page': page, 'limit': 10});
  ResponseModel<OrderModel> orderData = ResponseModel.fromJson(
      response.data, (json) => OrderModel.fromJson(json));
  return orderData;
}
