import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_calendar/schedule_bottom_sheet.dart';
import 'package:flutter_company_service/setups/setup_calendar/schedule_card.dart';
import 'package:get_it/get_it.dart';

import '../../database/drift_calendar/drift_database.dart';
import '../../database/drift_calendar/model/schedule_with_color.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              // 'drift_database.dart' 에서 query .where 문을 통해 이미 필터링을 다 함.
              // print('---- original data ----');
              // print(snapshot.data);
              //
              // List<Schedule> schedules = [];
              //
              // if (snapshot.hasData) {
              //   schedules = snapshot.data!
              //       .where((element) => element.date.toUtc() == selectedDate)
              //       .toList();
              //
              //   print('---- filtered data ----');
              //   print(schedules);
              // }

              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return const Center(
                  child: Text('스케줄이 없습니다.'),
                );
              }

              return ListView.separated(
                // itemCount: schedules.length,
                itemCount: snapshot.data!.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8.0);
                },
                itemBuilder: (context, index) {
                  print(snapshot.data);

                  // final schedule = schedules[index];
                  final scheduleWithColor = snapshot.data![index];

                  return Dismissible(
                    // Slide Action Widget
                    key: ObjectKey(scheduleWithColor.schedule.id),
                    direction: DismissDirection.endToStart,
                    onDismissed: (DismissDirection direction) {
                      GetIt.I<LocalDatabase>()
                          .removeSchedule(scheduleWithColor.schedule.id);
                    },
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (_) {
                            return ScheduleBottomSheet(
                              selectedDate: selectedDate,
                              scheduleId: scheduleWithColor.schedule.id,
                            );
                          },
                        );
                      },
                      child: ScheduleCard(
                        startTime: scheduleWithColor.schedule.startTime,
                        endTime: scheduleWithColor.schedule.endTime,
                        content: scheduleWithColor.schedule.content,
                        color: Color(
                          int.parse(
                            'FF${scheduleWithColor.categoryColor.hexCode}',
                            radix: 16,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
