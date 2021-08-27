import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response.dart';

Future<ResponseModel> tradecancel(int id) async {
  Response response =
      await iDio().post('/api/cellorder', queryParameters: {'id': id});
  return ResponseModel.fromJson(response.data, (json) => null);
}
