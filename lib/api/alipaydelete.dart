import 'package:huofu/api/http.dart';

alipaydelete(String id) async {
  return await iDio().post('/api/deletezfb', queryParameters: {'id': id});
}
