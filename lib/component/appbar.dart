import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_company_service/component/drawer.dart';
import 'package:flutter_company_service/firebase/auth.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:flutter_svg/svg.dart';

import '../path/image.dart';

AppBar commonAppBar({
  required String title,
  required BuildContext context,
}) {
  return AppBar(
    leading: Builder(
      builder: (context) {
        return IconButton(
          icon: SvgPicture.asset(COMMON_LIST),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
    backgroundColor: Colors.white70,
    centerTitle: true,
    title: Text(
      title,
      style: defaultFont,
    ),
    actions: [
      IconButton(
        icon: SvgPicture.asset(COMMON_NOTICE),
        onPressed: null,
      ),
      IconButton(
        icon: SvgPicture.asset(COMMON_LOG_OUT),
        onPressed: () async {
          print('now : ${FirebaseAuth.instance.currentUser?.email}');
          firebaseLogOut();
          await selectScreen(screen: 'login', context: context);
          print('logout : ${FirebaseAuth.instance.currentUser?.email}');
        },
      ),
    ],
  );
}
