import 'package:flutter/material.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:table_calendar/table_calendar.dart';

import 'const/decorations.dart';

class MyCalendar extends StatelessWidget {
  const MyCalendar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    Key? key,
  }) : super(key: key);

  final DateTime selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',
      focusedDay: focusedDay,
      firstDay: DateTime(1800),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false, // delete default 2weeks button
        titleCentered: true, // year, month align
        titleTextStyle: defaultFont,
        headerPadding: const EdgeInsets.symmetric(vertical: 5.0),
      ),
      daysOfWeekHeight: 35.0,
      calendarStyle: CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: defaultBoxDeco,
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        selectedDecoration: selectBoxDeco,
        outsideDecoration: outsideBoxDeco,
        selectedTextStyle: defaultFont.copyWith(
          color: Colors.green,
          fontWeight: FontWeight.w700,
        ),
        defaultTextStyle: defaultFont.copyWith(
          color: Colors.brown,
        ),
        weekendTextStyle: defaultFont.copyWith(
          color: Colors.red,
        ),
        outsideTextStyle: defaultFont.copyWith(
          color: Colors.blue,
        ),
        todayTextStyle: defaultFont.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.w700,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: defaultFont.copyWith(
          color: Colors.purple,
        ),
        weekendStyle: defaultFont.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      ),
      onDaySelected: onDaySelected,
      selectedDayPredicate: (DateTime date) {
        // marked as selected.
        // A function is executed for all days
        // ex) if last day 31, execute 31times

        return (date.year == selectedDay.year &&
            date.month == selectedDay.month &&
            date.day == selectedDay.day);
      },
    );
  }
}
