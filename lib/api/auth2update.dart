import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> auth2update(String id, String image) async {
  Response response = await iDio().post('/api/updatesauthenticate',
      queryParameters: {'id': id, 'images': image});
  return ResponseModel.fromJson(response.data, (json) => null);
}
