import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<OrderModel>> orderdetail(int orderid) async {
  Response response =
      await iDio().post('/api/orderinfo', queryParameters: {'id': orderid});
  ResponseModel<OrderModel> orderData = ResponseModel.fromJson(
      response.data, (json) => OrderModel.fromJson(json));
  return orderData;
}
