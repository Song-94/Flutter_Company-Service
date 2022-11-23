import 'package:flutter_dotenv/flutter_dotenv.dart';

String APP_ID = (dotenv.maybeGet('AGORA_VIDEO_APP_ID', fallback: ''))!;
String CHANNEL_NAME = (dotenv.maybeGet('AGORA_CHANNEL_NAME', fallback: ''))!;
String TEMP_TOKEN = (dotenv.maybeGet('AGORA_TEMP_TOKEN', fallback: ''))!;