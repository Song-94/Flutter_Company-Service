import 'package:flutter/material.dart';

import '../../../textfield/schedule_textfield.dart';

class BottomSheetTime extends StatelessWidget {
  const BottomSheetTime({
    required this.onStartSaved,
    required this.onEndSaved,
    required this.startInitialValue,
    required this.endInitialValue,
    Key? key,
  }) : super(key: key);

  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final String startInitialValue;
  final String endInitialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ScheduleTextField(
            label: '시작 시간',
            isTime: true,
            onSaved: onStartSaved,
            initialValue: startInitialValue,
          ),
        ),
        const SizedBox(
          width: 16.0,
        ),
        Expanded(
          child: ScheduleTextField(
            label: '마감 시간',
            isTime: true,
            onSaved: onEndSaved,
            initialValue: endInitialValue,
          ),
        ),
      ],
    );
  }
}
