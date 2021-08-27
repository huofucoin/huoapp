import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/api/mine.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> mobilecheck(String mobile, String vcode) async {
  Response response = await iDio().post('/api/mobilecheck',
      queryParameters: {'mobile': mobile, 'vcode': vcode});
  await mine();
  return ResponseModel.fromJson(response.data, (json) => null);
}
