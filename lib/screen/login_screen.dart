import 'package:flutter/material.dart';
import 'package:flutter_company_service/firebase/auth.dart';
import 'package:flutter_company_service/textfield/main_textfield.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../dialog/warning.dart';
import '../firebase/error.dart';
import '../textfield/const/type.dart';
import '../textstyle/textstyle.dart';
import '../path/image.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    Key? key,
  }) : super(key: key);

  bool isKeyboard = false;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, _isKeyboard) {
      widget.isKeyboard = _isKeyboard;
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Center(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  loginForm(),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                        ),
                        onPressed: onPressLogin,
                        child: const Text('Login'),
                      ),
                      const SizedBox(
                        width: 30.0,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/CreateUser');
                        },
                        child: const Text('Create'),
                      ),
                    ],
                  ),
                  _titleImage(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void clearController() {
    idController.clear();
    pwController.clear();
  }

  void onPressLogin() async {
    // _formKey.currentState!.save(); // onSaved call
    // print('ID TextField ${idController.text}');
    // print('PW TextField ${pwController.text}');

    if (_loginFormKey.currentState!.validate()) {
      // validate call
      print('Login form success.');

      final res =
          await firebaseSignIn(email: idController.text, pw: pwController.text);

      for (String element in signInEaPError) {
        if (res == 'Success') {
          print('Login Success : $res');
          if (widget.isKeyboard) {
            FocusScope.of(context).unfocus();
          }
          Navigator.pushNamed(context, '/Home');
          break;
        } else if (res == element) {
          print('Login Error: $res');
          await warningDialog(
            context: context,
            err: res,
          );
          break;
        } else {
          // print('Err Loop : [$err : $element]');
        }
      }
    } else {
      print('Login form fail');
    }
  }

  Widget loginForm() {
    return Form(
      key: _loginFormKey,
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

  Widget _titleImage() {
    return !widget.isKeyboard
        ? Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SvgPicture.asset(
                LOGIN_SCREEN_MAIN,
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Text(
                'Company Service',
                style: loginScreenTitle,
              ),
            ],
          )
        : Container();
  }
}
