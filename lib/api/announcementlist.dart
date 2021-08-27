import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/announcement.dart';
import 'package:huofu/model/response1.dart';

Future<ResponseModel<AnnouncementModel>> announcementlist(int page) async {
  Response response = await iDio()
      .post('/api/announcementlist', queryParameters: {'page': page});
  ResponseModel<AnnouncementModel> data = ResponseModel.fromJson(
      response.data, (json) => AnnouncementModel.fromJson(json));
  return data;
}
