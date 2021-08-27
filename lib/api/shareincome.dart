import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/shareoverview.dart';

Future<ResponseModel<ShareOverviewModel>> shareincome(int page) async {
  Response response = await iDio()
      .post('/api/friendincome', queryParameters: {'page': page, 'limit': 10});
  return ResponseModel.fromJson(
      response.data, (json) => ShareOverviewModel.fromJson(json));
}
