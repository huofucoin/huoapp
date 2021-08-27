import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/api/mine.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ResponseModel<UserInfoModel>> login(
    String mobile, String password, int type) async {
  Response response = await iDio().post('/api/login', queryParameters: {
    type == 1 ? 'mobile' : 'email': mobile,
    'password': password,
    'type': type.toString()
  });
  ResponseModel<UserInfoModel> data = ResponseModel<UserInfoModel>.fromJson(
      response.data, (json) => UserInfoModel.fromJson(json));
  if (data.token != null) {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data.token ?? '');
  }
  if (data.code == 0) {
    return await mine();
  }
  return data;
}
