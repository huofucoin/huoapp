import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/main.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/userinfo.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

Future<ResponseModel<UserInfoModel>> mine() async {
  Response response = await iDio().post('/api/mine');
  ResponseModel<UserInfoModel> data = ResponseModel.fromJson(
      response.data, (json) => UserInfoModel.fromJson(json));
  if (data.code == 0 && data.data != null) {
    Provider.of<UserState>(navigatorKey.currentContext!, listen: false)
        .login(data.data!);
  }
  return data;
}
