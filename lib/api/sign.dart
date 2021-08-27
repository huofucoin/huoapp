import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/api/mine.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/userinfo.dart';

Future<ResponseModel<UserInfoModel>> sign() async {
  Response response = await iDio().post('/api/sign');
  await mine();
  return ResponseModel.fromJson(
      response.data, (json) => UserInfoModel.fromJson(json));
}
