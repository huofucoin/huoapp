import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/zichan.dart';

Future<ResponseModel<ZiChanModel>> zichan() async {
  Response response = await iDio().post('/api/zichan');
  ResponseModel<ZiChanModel> data = ResponseModel.fromJson(
      response.data, (json) => ZiChanModel.fromJson(json));
  return data;
}
