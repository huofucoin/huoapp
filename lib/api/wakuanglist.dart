import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/wakuang.dart';

Future<ResponseModel<WaKuangModel>> wakuanglist(int status, int page) async {
  Response response = await iDio().post('/api/wakuanglist',
      queryParameters: {'status': status, 'page': page, 'limit': 10});
  ResponseModel<WaKuangModel> data = ResponseModel.fromJson(
      response.data, (json) => WaKuangModel.fromJson(json));
  return data;
}
