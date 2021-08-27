import 'package:huofu/api/http.dart';

bankdelete(String id) async {
  return await iDio().post('/api/deletebank', queryParameters: {'id': id});
}
