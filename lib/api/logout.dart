import 'package:huofu/api/http.dart';

logout() async {
  var response = await iDio().post('/api/logout');
  return response.data;
}
