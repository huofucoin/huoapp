import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/sign.dart';

Future<ResponseModel<SignModel>> signdetial(int page) async {
  Response response = await iDio()
      .post('/api/signdetail', queryParameters: {'page': page, 'limit': 10});
  return ResponseModel.fromJson(
      response.data, (json) => SignModel.fromJson(json));
}
