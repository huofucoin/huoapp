import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel> messageread(int id) async {
  Response response =
      await iDio().post('/api/read', queryParameters: {'id': id});
  ResponseModel data = ResponseModel.fromJson(response.data, (json) => null);
  return data;
}
