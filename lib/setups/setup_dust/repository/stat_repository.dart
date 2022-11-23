import 'package:dio/dio.dart';

import '../../../database/hive_dust/hive_database.dart';
import '../const/data.dart';

class StatRepository {
  static Future<List<StatModel>> fetchData({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey': SERVICE_KEY,
        'returnType': 'json',
        'numOfRows': 30,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    return response.data['response']['body']['items']
        .map<StatModel>(
          (item) => StatModel.fromJson(json: item),
        )
        .toList();
  }
}
