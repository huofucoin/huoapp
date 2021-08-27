import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/share.dart';

Future<ResponseModel<ShareModel>> share() async {
  Response response = await iDio().post('/api/yaoqinghaoyou');
  return ResponseModel.fromJson(
      response.data, (json) => ShareModel.fromJson(json));
}
