import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response2.dart';

Future<ResponseModel> messageunread() async {
  Response response = await iDio().post('/api/messageread');
  ResponseModel data = ResponseModel.fromJson(response.data);
  return data;
}
