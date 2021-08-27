import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/api/mine.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/userinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ResponseModel<UserInfoModel>> register(String username, String password,
    String vcode, String parentcodes, bool isMobile) async {
  Response response = await iDio().post(
      isMobile ? '/api/register' : '/api/emailregister',
      queryParameters: {
        isMobile ? 'mobile' : 'emails': username,
        'vcode': vcode,
        'password': password,
        'parentcodes': parentcodes
      });
  ResponseModel<UserInfoModel> data = ResponseModel.fromJson(
      response.data, (json) => UserInfoModel.fromJson(json));
  if (data.token != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', data.token ?? '');
  }
  if (data.code == 0) {
    await mine();
  }
  return data;
}
