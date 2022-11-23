import 'package:flutter_dotenv/flutter_dotenv.dart';

// Dio Package 사용 시 알아서 Encoding 해줌.
// 따라서 Decoding 인증키를 사용해야 함.
String? SERVICE_KEY = dotenv.maybeGet('AIR_POLLUTION_API_KEY', fallback: null);
const REQUEST_COUNT = 10;
const SHOW_KEY_LIST = 10;
const BOX_NAME = 'test';
