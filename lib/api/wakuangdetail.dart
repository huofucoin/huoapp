import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/wakuang.dart';

Future<ResponseModel<WaKuangModel>> wakuangdetail(int id) async {
  Response response =
      await iDio().post('/api/wakuangdetail', queryParameters: {'id': id});
  ResponseModel<WaKuangModel> data = ResponseModel.fromJson(
      response.data, (json) => WaKuangModel.fromJson(json));
  return data;
}
