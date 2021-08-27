import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/sxf.dart';

Future<ResponseModel<SXFModel>> ordersxf(double count) async {
  Response response =
      await iDio().post('/api/otcsxf', queryParameters: {'count': count});
  ResponseModel<SXFModel> data =
      ResponseModel.fromJson(response.data, (json) => SXFModel.fromJson(json));
  return data;
}
