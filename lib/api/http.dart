import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:huofu/login/login.dart';
import 'package:huofu/main.dart';
import 'package:huofu/state/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String host = 'prod.huofu.ltd';
const int port = 8576;

final Dio dio =
    Dio(BaseOptions(baseUrl: 'http://' + host + ':' + port.toString()));
final Interceptor interceptor =
    InterceptorsWrapper(onRequest: (options, handler) async {
  print('onRequest---' + options.path);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token') ?? "";
  options.queryParameters['token'] = token;
  print(options.path + ' ' + options.queryParameters.toString());
  return handler.next(options);
}, onResponse: (response, handler) {
  print('onResponse---' + response.requestOptions.path);
  print(response.requestOptions.path + ' ' + response.data.toString());
  if (response.data['code'] == 888) {
    Provider.of<UserState>(navigatorKey.currentContext!, listen: false)
        .logout();
    Navigator.of(navigatorKey.currentContext!).pushNamed('/login');
  }
  return handler.next(response);
}, onError: (DioError e, handler) {
  print('onError');
  print(e);
  return handler.next(e);
});

Dio iDio() {
  if (dio.interceptors.indexOf(interceptor) < 0) {
    dio.interceptors.add(interceptor);
  }
  return dio;
}
