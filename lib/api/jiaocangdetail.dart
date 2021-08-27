import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/jiaocang.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel<JiaoCangModel>> jiaocangdetail(int id) async {
  Response response =
      await iDio().post('/api/jiaocangdetail', queryParameters: {'id': id});
  ResponseModel<JiaoCangModel> data = ResponseModel.fromJson(
      response.data, (json) => JiaoCangModel.fromJson(json));
  return data;
}
