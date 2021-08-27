import 'package:huofu/api/http.dart';

updatepassword(String old, String password, String vcode, bool isMobile) async {
  var response = await iDio().post('/api/updatepassword', queryParameters: {
    'password': password,
    'type': isMobile ? '1' : '2',
    'vcode': vcode
  });
  return response.data;
}
