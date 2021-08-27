import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/wakuang.dart';

Future<ResponseModel<WaKuangModel>> wakuang(int id, int count) async {
  Response response = await iDio()
      .post('/api/wakuang', queryParameters: {'id': id, 'count': count});
  ResponseModel<WaKuangModel> data = ResponseModel.fromJson(
      response.data, (json) => WaKuangModel.fromJson(json));
  return data;
}
