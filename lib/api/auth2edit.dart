import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> auth2edit(String image) async {
  Response response = await iDio()
      .post('/api/sauthenticate', queryParameters: {'images': image});
  return ResponseModel.fromJson(response.data, (json) => null);
}
