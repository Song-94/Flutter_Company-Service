import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_calendar/calendar.dart';

import '../setups/setup_calendar/schedule_banner.dart';
import '../setups/setup_calendar/schedule_bottom_sheet.dart';
import '../setups/setup_calendar/schedule_list.dart';
import '../component/drawer.dart';
import '../component/appbar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      appBar: commonAppBar(title: 'CalenderScreen', context: context),
      drawer: commonDrawer(context: context),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            MyCalendar(
              selectedDay: selectedDay,
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,
            ),
            const SizedBox(height: 8.0),
            ScheduleBanner(
              selectedDay: selectedDay,
            ),
            const SizedBox(height: 8.0),
            ScheduleList(
              selectedDate: selectedDay,
            ),
          ],
        ),
      ),
      floatingActionButton: renderFloatingActionButton(),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) {
            return SafeArea(
              child: ScheduleBottomSheet(
                selectedDate: selectedDay,
              ),
            );
          },
        );
      },
      backgroundColor: Colors.grey,
      child: const Icon(Icons.add),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // select day event.
    print('Select: $selectedDay , Focus: $focusedDay');
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay;
    });
  }
}
