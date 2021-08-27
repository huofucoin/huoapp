import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> tradecreate(int type, String price, String number) async {
  Response response = await iDio().post('/api/insertorder',
      queryParameters: {'type': type, 'price': price, 'number': number});
  return ResponseModel.fromJson(response.data, (json) => null);
}
