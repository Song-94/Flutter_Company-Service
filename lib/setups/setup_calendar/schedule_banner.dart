import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_calendar/const/decorations.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:get_it/get_it.dart';

import '../../database/drift_calendar/drift_database.dart';
import '../../database/drift_calendar/model/schedule_with_color.dart';

class ScheduleBanner extends StatelessWidget {
  const ScheduleBanner({
    required this.selectedDay,
    Key? key,
  }) : super(key: key);

  final DateTime selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: defaultBoxDeco.copyWith(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _trDayKorean(selectedDay),
              style: defaultFont.copyWith(
                color: Colors.white,
              ),
            ),
            StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
              builder: (context, snapshot) {
                int count = 0;

                if (snapshot.hasData) {
                  count = snapshot.data!.length;
                }

                return Text(
                  '$count개',
                  style: defaultFont,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _trDayKorean(DateTime day) {
    return '${day.year}년 ${day.month}년 ${day.day}일';
  }
}
