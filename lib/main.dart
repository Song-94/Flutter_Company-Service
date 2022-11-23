import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_company_service/account/account.dart';
import 'package:flutter_company_service/screen/attendance_screen.dart';
import 'package:flutter_company_service/screen/calendar_screen.dart';
import 'package:flutter_company_service/screen/call_screen.dart';
import 'package:flutter_company_service/screen/dust_screen.dart';
import 'package:flutter_company_service/screen/home_screen.dart';
import 'package:flutter_company_service/screen/login_screen.dart';
import 'package:flutter_company_service/screen/ready_screen.dart';
import 'package:flutter_company_service/screen/create_user_screen.dart';
import 'package:flutter_company_service/screen/today_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:drift/drift.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'color/colors.dart';
import 'database/drift_calendar/drift_database.dart';

void main() async {
  // if async method use, you need to call ensureInitialized.
  WidgetsFlutterBinding.ensureInitialized(); // plugins initialize.
  await initializeDateFormatting('ko_KR', null);
  await Firebase.initializeApp();

  await dotenv.load(fileName: "env/.origin_env");

  final database = LocalDatabase();
  final account = AccountInfo();

  // GetIt Instance register
  GetIt.I.registerSingleton<LocalDatabase>(database);
  GetIt.I.registerSingleton<AccountInfo>(account);

  // final colors = await database.getCategoryColors();
  final colors = await GetIt.I<LocalDatabase>().getCategoryColors();

  if (colors.isEmpty) {
    for (String hexCode in SCHEDULE_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          // id : integer().autoIncrement()로 자동 증가.
          hexCode: Value(hexCode),
        ),
      );
    }
  }

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'GE,'),
      initialRoute: '/Login',
      routes: {
        '/Login': (context) => LoginScreen(),
        '/Home': (context) => const HomeScreen(),
        '/Today': (context) => const TodayScreen(),
        '/Calender': (context) => const CalendarScreen(),
        '/Attendance': (context) => const AttendanceScreen(),
        '/Dust': (context) => const DustScreen(),
        '/Call': (context) => const CallScreen(),
        '/Ready': (context) => const ReadyScreen(),
        '/CreateUser': (context) => const CreateUserScreen(),
      },
    ),
  );
}
