import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> alipayupdate(
    String id, String number, String image, String vcode) async {
  Response response = await iDio().post('/api/updatezfb', queryParameters: {
    'id': id,
    'numbers': number,
    'images': image,
    'type': 1,
    'vcode': vcode
  });
  return ResponseModel.fromJson(response.data, (json) => null);
}
