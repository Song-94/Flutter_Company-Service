import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../color/colors.dart';

class ScheduleTextField extends StatelessWidget {
  const ScheduleTextField({
    required this.label,
    required this.isTime,
    required this.onSaved,
    required this.initialValue,
    Key? key,
  }) : super(key: key);

  final String label;
  final String initialValue;

  final bool isTime; // if is true, input only number.
  final FormFieldSetter<String> onSaved;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: hex2color(PRIMARY_COLOR),
            fontWeight: FontWeight.w600,
          ),
        ),
        if (isTime) renderTextField(),
        if (!isTime)
          Expanded(
            child: renderTextField(),
          ),
      ],
    );
  }

  Widget renderTextField() {
    return TextFormField(
      onSaved: onSaved,
      validator: (String? val) {
        // if return 'null', no error.
        // if return String about error, has error
        if (val == null || val.isEmpty) {
          // 검증 용도
          return '값을 입력해주세요';
        }

        return null;
      },
      cursorColor: Colors.grey,
      maxLines: isTime ? 1 : null,
      expands: isTime ? false : true,
      initialValue: initialValue,
      keyboardType: isTime
          ? TextInputType.number
          : TextInputType.multiline, // default keyboardType
      inputFormatters: isTime
          ? [
        // only allow input number
        FilteringTextInputFormatter.digitsOnly,
      ]
          : [],
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true, // filled is true, we can use fillColor
        fillColor: Colors.grey[300]!,
        suffixText: isTime ? '시' : null,
      ),
    );
  }
}
