import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/main.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/sksign.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';

Future<ResponseModel<SKSignModel>> sksign() async {
  Response response = await iDio().post('/api/sksign');
  ResponseModel<SKSignModel> data = ResponseModel.fromJson(
      response.data, (json) => SKSignModel.fromJson(json));
  if (data.code == 0 &&
      data.sign != null &&
      navigatorKey.currentContext != null) {
    Provider.of<UserState>(navigatorKey.currentContext!, listen: false).skSign =
        data.sign!;
  }
  return data;
}
