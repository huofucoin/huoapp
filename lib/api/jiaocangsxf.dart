import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/sxf.dart';

Future<ResponseModel<SXFModel>> jiaocangsxf(int id, int count) async {
  Response response = await iDio()
      .post('/api/wakuangsxf', queryParameters: {'id': id, 'count': count});
  ResponseModel<SXFModel> data =
      ResponseModel.fromJson(response.data, (json) => SXFModel.fromJson(json));
  return data;
}
