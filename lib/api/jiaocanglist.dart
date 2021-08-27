import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/jiaocang.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<JiaoCangModel>> jiaocanglist(int page) async {
  Response response = await iDio()
      .post('/api/jiaocanglist', queryParameters: {'page': page, 'limit': 10});
  ResponseModel<JiaoCangModel> data = ResponseModel.fromJson(
      response.data, (json) => JiaoCangModel.fromJson(json));
  return data;
}
