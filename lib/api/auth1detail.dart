import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/auth1.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<Auth1Model>> auth1detail() async {
  Response response = await iDio().post('/api/userfauthenticate');
  return ResponseModel.fromJson(
      response.data, (json) => Auth1Model.fromJson(json));
}
