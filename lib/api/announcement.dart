import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/announcement.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<AnnouncementModel>> announcement() async {
  Response response = await iDio().post('/api/announcement');
  ResponseModel<AnnouncementModel> data = ResponseModel.fromJson(
      response.data, (json) => AnnouncementModel.fromJson(json));
  return data;
}
