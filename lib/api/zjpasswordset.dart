import 'package:huofu/api/http.dart';

setzjpassword(String password, String vcode, bool isMobile) async {
  var response = await iDio().post('/api/setzjpassword', queryParameters: {
    'password': password,
    'vcode': vcode,
    'type': isMobile ? '1' : '2'
  });
  return response.data;
}
