import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/help.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<HelpModel>> bangzhu() async {
  Response response = await iDio().post('/api/bangzhu');
  ResponseModel<HelpModel> data =
      ResponseModel.fromJson(response.data, (json) => HelpModel.fromJson(json));
  return data;
}
