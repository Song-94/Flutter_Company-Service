import 'package:flutter/material.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';

class CheckTextFormField extends StatelessWidget {
  const CheckTextFormField({
    required this.controller,
    required this.textStyle,
    required this.checkText,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final TextStyle textStyle;
  final String checkText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textStyle,
      obscureText: true,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: const Icon(Icons.clear),
        ),
        labelText: 'Please input password.',
        labelStyle: defaultFont.copyWith(fontSize: 20.0),
      ),
      validator: (text) {
        if (controller.text != checkText) {
          print('function validator ${controller.text} : $checkText ');
          return 'Check your password.';
        }
      },
    );
  }
}
