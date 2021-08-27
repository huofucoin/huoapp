import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/kup.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<KupModel>> tradeup() async {
  Response response = await iDio().post('/api/kup');
  return ResponseModel.fromJson(
      response.data, (json) => KupModel.fromJson(json['data'] ?? json));
}
