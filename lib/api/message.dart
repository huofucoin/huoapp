import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/message.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<MessageModel>> message(int page) async {
  Response response = await iDio()
      .post('/api/messagelist', queryParameters: {'page': page, 'limit': 10});
  ResponseModel<MessageModel> data = ResponseModel.fromJson(
      response.data, (json) => MessageModel.fromJson(json));
  return data;
}
