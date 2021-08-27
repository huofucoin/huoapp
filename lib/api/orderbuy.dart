import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/orderpre.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<OrderModel>> orderbuy(int paytype, double count) async {
  Response response =
      await iDio().post('/api/bankinfo', queryParameters: {'money': count});
  ResponseModel<OrderPreModel> prebuyData = ResponseModel.fromJson(
      response.data, (json) => OrderPreModel.fromJson(json));
  if (prebuyData.code == 0 && prebuyData.data != null) {
    Response response = await iDio().post('/api/buyorder', queryParameters: {
      'paytype': paytype,
      'count': count.toString(),
      'managerid': prebuyData.data!.id
    });
    ResponseModel<OrderModel> orderData = ResponseModel.fromJson(
        response.data, (json) => OrderModel.fromJson(json));
    return orderData;
  } else {
    return ResponseModel.fromJson(prebuyData.toJson((value) => null),
        (json) => OrderModel.fromJson(json));
  }
}
