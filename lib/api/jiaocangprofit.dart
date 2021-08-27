import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/profit.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<ProfitModel>> jiaocangprofit(int id, int count) async {
  Response response = await iDio()
      .post('/api/profit', queryParameters: {'id': id, 'count': count});
  ResponseModel<ProfitModel> data = ResponseModel.fromJson(
      response.data, (json) => ProfitModel.fromJson(json));
  return data;
}
