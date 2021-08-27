import 'package:huofu/api/http.dart';
import 'package:huofu/api/orderdetail.dart';
import 'package:huofu/model/order.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<OrderModel>> orderconfirm(
    int orderid, String zjpassword) async {
  await iDio().post('/api/collectsuccess',
      queryParameters: {'id': orderid, 'zjpassword': zjpassword});
  return await orderdetail(orderid);
}
