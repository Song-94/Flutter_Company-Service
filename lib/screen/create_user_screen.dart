import 'package:flutter/material.dart';
import 'package:flutter_company_service/firebase/auth.dart';
import 'package:flutter_company_service/firebase/error.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../dialog/warning.dart';
import '../path/image.dart';
import '../textfield/check_textfield.dart';
import '../textfield/const/type.dart';
import '../textfield/main_textfield.dart';
import '../textstyle/textstyle.dart';

class CreateUserScreen extends StatefulWidget {
  const CreateUserScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends State<CreateUserScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController checkController = TextEditingController();

  final GlobalKey<FormState> _createFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _checkFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    checkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboard) {
        print('keyboard : $isKeyboard');
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                'CreateUserScreen',
                style: defaultFont.copyWith(color: Colors.white),
              ),
            ),
            body: Column(
              mainAxisAlignment: isKeyboard
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: <Widget>[
                isKeyboard
                    ? const SizedBox(height: 30.0)
                    : SvgPicture.asset(
                        CREATE_USER_SCREEN_MAIN,
                        height: 150,
                      ),
                createForm(),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () => onPressCreate(),
                  child: const Text('Create'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void onPressCheck() async {
    if (_checkFormKey.currentState == null) {
      print('onPressCheck what is wrong?');
      return;
    }
    if (_checkFormKey.currentState!.validate()) {
      print('onPressCheck form success');
      final res =
          await firebaseCreate(email: idController.text, pw: pwController.text);

      print('creating ${idController.text} ${pwController.text}');

      for (String element in createEaPError) {
        if (res == 'Success') {
          print('onPressCheck Success : $res');

          Navigator.pushNamed(context, '/Login');
          break;
        } else if (res == element) {
          print('onPressCheck: $element');
          await warningDialog(
            context: context,
            err: res,
          );

          if (res == 'email-already-in-use' || res == 'invalid-email') {
            idController.clear();
          }

          Navigator.pushNamed(context, '/CreateUser');
          break;
        } else {
          // print('Err Loop : [$err : $element]');
        }
      }
    } else {
      print('onPressCheck fail');
    }
  }

  void onPressCreate() async {
    if (_createFormKey.currentState == null) {
      print('onPressCreate what is wrong?');
      return;
    }
    if (_createFormKey.currentState!.validate()) {
      print('onPressCreate form success');
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return checkDialog();
          });
    }
  }

  Widget checkDialog() {
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Please, Check your information',
        style: defaultFont.copyWith(fontSize: 15.0),
      ),
      content: checkForm(),
      actions: [
        TextButton(
          onPressed: onPressCheck,
          child: const Text('OK'),
        ),
      ],
    );
  }

  Widget createForm() {
    return Form(
      key: _createFormKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50.0),
            child: MainTextFormField(
              controller: idController,
              formType: FormType.email,
              labelText: 'ID',
              hintText: 'ID',
              textStyle: defaultFont,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 50.0),
            child: MainTextFormField(
              controller: pwController,
              formType: FormType.password,
              labelText: 'PW',
              hintText: 'PW',
              textStyle: defaultFont,
            ),
          ),
        ],
      ),
    );
  }

  Widget checkForm() {
    return Form(
      key: _checkFormKey,
      child: SizedBox(
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID : ${idController.text}',
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 30.0),
            CheckTextFormField(
              controller: checkController,
              checkText: pwController.text,
              textStyle: defaultFont,
            ),
          ],
        ),
      ),
    );
  }
}
