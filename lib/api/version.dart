import 'dart:io';

import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';
import 'package:huofu/model/version.dart';

Future<ResponseModel<VersionModel>> version() async {
  Response response = await iDio().post('/api/version', queryParameters: {
    'apptype': Platform.isAndroid ? 1 : (Platform.isIOS ? 2 : 0)
  });
  ResponseModel<VersionModel> orderData = ResponseModel.fromJson(
      response.data, (json) => VersionModel.fromJson(json));
  return orderData;
}
