import 'package:flutter/material.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:flutter_svg/svg.dart';

import '../component/appbar.dart';
import '../component/drawer.dart';
import '../path/image.dart';

class ReadyScreen extends StatelessWidget {
  const ReadyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      appBar: commonAppBar(title: 'ReadyScreen', context: context),
      drawer: commonDrawer(context: context),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  READY_SCREEN_MAIN,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 2,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.width / 4,
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 4,
                  child: const CircularProgressIndicator(),)
              ],
            ),
            const SizedBox(height: 30.0),
            const Text(
              'SERVICE IS NOT READY',
              style: defaultFont,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
