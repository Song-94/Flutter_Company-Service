import 'package:flutter_company_service/database/hive_dust/model/status_model.dart';

import '../hive_database.dart';

class StatAndStatusModel {
  StatAndStatusModel({
    required this.itemCode,
    required this.status,
    required this.stat,
  });

  final ItemCode itemCode; // 미세먼지 / 초미세먼지
  final StatusModel status;
  final StatModel stat;
}
