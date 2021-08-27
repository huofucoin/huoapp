import 'package:dio/dio.dart';
import 'package:huofu/api/http.dart';
import 'package:huofu/model/response1.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:k_chart/entity/k_line_entity.dart';

Future<ResponseModel<KLineEntity>> tradekline(String times) async {
  Response response =
      await iDio().post('/api/kline', queryParameters: {'times': times});
  return ResponseModel.fromJson(response.data, (json) {
    json['time'] = (DateTime.tryParse(json['time']) ?? DateTime.now())
        .millisecondsSinceEpoch;
    json['vol'] = json['volume'];
    json['amount'] = json['volume'];
    json['ratio'] = 0;
    json['change'] = 0;
    json['change'] = json['close'] - json['open'];
    json['ratio'] = json['change'] / json['open'];
    return KLineEntity.fromJson(json);
  });
}
