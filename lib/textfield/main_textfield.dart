import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'const/type.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    required this.controller,
    required this.textStyle,
    this.labelText,
    this.hintText,
    this.formType = FormType.none,
    this.equalText,
    Key? key,
  }) : super(key: key);

  final TextEditingController controller;
  final TextStyle textStyle;
  final String? labelText;
  final String? hintText;
  final FormType formType;
  final String? equalText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        // 텍스트 필드 클릭 시 함수 호출
        // print('onTap');
      },
      onChanged: (text) {
        // 내용 변경 될 때마다 함수 호출
        // print('onChanged $text');
      },
      onEditingComplete: () {
        // click Bottom Right Button, but void function
        FocusScope.of(context).requestFocus(FocusNode());
        // print('onEditingComplete');
      },
      onFieldSubmitted: (text) {
        // click Bottom Right Button
        FocusScope.of(context).requestFocus(FocusNode());
        // print('onFieldSubmitted $text');
      },
      onSaved: (text) {
        // FormKey 호출 : _formKey.currentState!.save();
        // print('onSaved $text');
      },
      validator: (text) {
        if (text == null) {
          return null;
        }
        if (formType == FormType.email) {
          if (!EmailValidator.validate(text)) {
            return 'Enter Email-Form.';
          }
        } else if (formType == FormType.password) {
          if (text.length < 6) {
            return 'Enter at least 6 digits.';
          }
        }

        print('validator $text');
      },
      obscureText: (formType == FormType.password) ? true : false,
      style: textStyle,
      cursorColor: Colors.black,
      controller: controller,
      keyboardType: (formType == FormType.email)
          ? TextInputType.emailAddress
          : TextInputType.text,
      decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.clear),
          ),
          labelText: labelText,
          hintText: hintText,
          icon: const Icon(Icons.android),
          labelStyle: textStyle,
          border: outlineInputBorder(Colors.black),
          enabledBorder: outlineInputBorder(Colors.black),
          focusedBorder: outlineInputBorder(Colors.redAccent)),
    );
  }

  OutlineInputBorder outlineInputBorder(Color color) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(10.0),
      ),
      borderSide: BorderSide(
        width: 2.0,
        color: color,
      ),
    );
  }
}
