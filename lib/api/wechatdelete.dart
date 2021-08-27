import 'package:huofu/api/http.dart';

wechatdelete(String id) async {
  return await iDio().post('/api/deleteweixin', queryParameters: {'id': id});
}
