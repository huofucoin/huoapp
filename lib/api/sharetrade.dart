import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
import 'package:huofu/model/sharesignup.dart';

Future<ResponseModel<ShareSignupModel>> sharetrade(int type, int page) async {
  Response response = await iDio().post('/api/transactionincome',
      queryParameters: {'type': type, 'page': page, 'limit': 10});
  return ResponseModel.fromJson(
      response.data, (json) => ShareSignupModel.fromJson(json));
}
