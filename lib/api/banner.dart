import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/banner.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<BannerModel>> banner() async {
  Response response = await iDio().post('/api/banner');
  ResponseModel<BannerModel> data = ResponseModel.fromJson(
      response.data, (json) => BannerModel.fromJson(json));
  return data;
}
