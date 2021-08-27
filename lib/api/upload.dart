import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';

upload(String file) async {
  var formData = FormData.fromMap({
    'files': [MultipartFile.fromFileSync(file)]
  });
  return await iDio().post('/api/upload', data: formData);
}
