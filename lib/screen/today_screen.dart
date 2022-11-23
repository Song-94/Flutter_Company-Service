import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/appbar.dart';
import '../component/drawer.dart';
import '../setups/setup_today/bottom_part.dart';
import '../setups/setup_today/top_part.dart';

class TodayScreen extends StatefulWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  State<TodayScreen> createState() => _TodayScreenState();
}

class _TodayScreenState extends State<TodayScreen> {
  DateTime selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      appBar: commonAppBar(title: 'TodayScreen', context: context),
      drawer: commonDrawer(context: context),
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TopPart(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              const BottomPart(),
            ],
          ),
        ),
      ),
    );
  }

  void onHeartPressed() {
    final DateTime now = DateTime.now();

    // dialog
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.white,
            height: 300.0,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              maximumDate: DateTime(
                now.year,
                now.month,
                now.day,
              ),
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
