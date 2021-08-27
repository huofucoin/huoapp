import 'package:huofu/api/http.dart';

forgetpassword(
    String mobile, String password, String vcode, bool isMobile) async {
  var response = await iDio().post(
      isMobile ? '/api/forgetpassword' : '/api/emailforgetpassword',
      queryParameters: {
        isMobile ? 'mobile' : 'email': mobile,
        'password': password,
        'vcode': vcode
      });
  return response.data;
}
