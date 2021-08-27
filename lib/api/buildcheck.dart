import 'package:dio/dio.dart';

Future<Response> buildcheck() async {
  return await Dio().get('http://invitation.huofu.ltd/buildcheck');
}
