import 'package:huofu/api/http.dart';

wechatupdate(String id, String number, String image, String vcode) async {
  return await iDio().post('/api/updateweixin', queryParameters: {
    'id': id,
    'numbers': number,
    'images': image,
    'type': 1,
    'vcode': vcode
  });
}
