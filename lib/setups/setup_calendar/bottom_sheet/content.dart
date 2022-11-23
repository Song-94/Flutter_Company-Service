import 'package:flutter/material.dart';

import '../../../textfield/schedule_textfield.dart';

class BottomSheetContent extends StatelessWidget {
  const BottomSheetContent({
    required this.onSaved,
    required this.initialValue,
    Key? key,
  }) : super(key: key);

  final FormFieldSetter<String> onSaved;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScheduleTextField(
        label: '내용',
        isTime: false,
        onSaved: onSaved,
        initialValue: initialValue,
      ),
    );
  }
}