import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> bankedit(
    String number, String bank, String branch, String vcode) async {
  Response response = await iDio().post('/api/bingbank', queryParameters: {
    'type': 1,
    'cardnumber': number,
    'bankname': bank,
    'fetchbank': branch,
    'vcode': vcode
  });
  return ResponseModel.fromJson(response.data, (json) => null);
}
