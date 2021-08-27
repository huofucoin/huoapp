import 'package:huofu/api/http.dart';
import 'package:huofu/api/orderdetail.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<OrderModel>> orderpay(int orderid) async {
  await iDio().post('/api/paysuccess', queryParameters: {'id': orderid});
  return await orderdetail(orderid);
}
