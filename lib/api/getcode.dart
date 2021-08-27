import 'package:huofu/api/http.dart';

getcode(String mobile, String type, bool isMobile) async {
  var response = await iDio().post(
      isMobile ? '/api/getcode' : '/api/emailgetcode',
      queryParameters: {isMobile ? 'mobile' : 'email': mobile, 'type': type});
  return response.data;
}
