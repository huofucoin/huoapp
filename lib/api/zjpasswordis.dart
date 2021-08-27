import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> zjpasswordis() async {
  Response response = await iDio().post('/api/iszjpassword');
  return ResponseModel.fromJson(response.data, (json) => null);
}
