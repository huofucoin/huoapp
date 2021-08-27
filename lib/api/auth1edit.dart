import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> auth1edit(String username, String cardnumber,
    String frontImage, String backImage) async {
  Response data = await iDio().post('/api/fauthenticate', queryParameters: {
    'username': username,
    'cardnumber': cardnumber,
    'frontimage': frontImage,
    'backimage': backImage
  });
  return ResponseModel.fromJson(data.data, (json) => null);
}
