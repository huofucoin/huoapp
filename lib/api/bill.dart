import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/bill.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<BillModel>> bill(int type, int page) async {
  Response response = await iDio().post('/api/bill',
      queryParameters: {'type': type, 'page': page, 'limit': 10});
  ResponseModel<BillModel> data =
      ResponseModel.fromJson(response.data, (json) => BillModel.fromJson(json));
  return data;
}
