import 'package:flutter/material.dart';
import 'package:flutter_company_service/path/image.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../component/drawer.dart';
import '../component/appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEnableOpenDragGesture: false,
      appBar: commonAppBar(title: 'HomeScreen', context: context),
      drawer: commonDrawer(context: context),
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 50.0),
          Text(
            '안녕하세요.',
            style: loginScreenTitle,
          ),
          SvgPicture.asset(
            HOME_SCREEN_MAIN,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.height / 2,
          ),
        ],
      ),
    );
  }
}
