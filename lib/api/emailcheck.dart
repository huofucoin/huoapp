import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/api/mine.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> emailcheck(String mobile, String vcode) async {
  Response response = await iDio().post('/api/emailcheck',
      queryParameters: {'email': mobile, 'vcode': vcode});
  await mine();
  return ResponseModel.fromJson(response.data, (json) => null);
}
