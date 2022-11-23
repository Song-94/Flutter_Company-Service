import 'package:flutter/material.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:flutter_company_service/path/image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg_provider;

Drawer commonDrawer({
  required BuildContext context,
}) {
  return Drawer(
    elevation: 0,
    backgroundColor: Colors.grey,
    child: ListView(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            image: const DecorationImage(
              scale: 2.0,
              image: svg_provider.Svg(PROFILE_DEAFULT),
              alignment: Alignment.topLeft,
            ),
            color: Colors.red[200],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: drawerInfo(
            name: '이름     : 송기웅',
            position: '직책     : 사원',
            part: '근무처 : 연구소',
          ),
        ),
        ...List<Widget>.generate(
          drawerList.length,
          (index) => Padding(
            padding: const EdgeInsets.all(4.0),
            child: ListTile(
              tileColor: Colors.white70,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 2.0),
                borderRadius: BorderRadius.circular(20.0),
              ),
              // 프로필 아래 메뉴 칸
              leading: SvgPicture.asset(
                drawerList.values.elementAt(index),
                height: 50,
              ),
              title: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Text(
                  drawerList.keys.elementAt(index),
                  textAlign: TextAlign.right,
                  style: defaultFont,
                ),
              ),
              onTap: () async {
                FocusManager.instance.primaryFocus?.unfocus();
                debugPrint('${drawerList.keys.elementAt(index)} is Clicked');
                await selectScreen(
                    screen: drawerList.keys.elementAt(index), context: context);
              },
              trailing: const Icon(Icons.double_arrow), // + 버튼 추가
            ),
          ),
        ).toList(),
      ],
    ),
  );
}

Future<void> selectScreen({
  required String screen,
  required BuildContext context,
}) async {
  switch (screen) {
    case 'login':
      Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
      break;

    case 'home':
      Navigator.pushNamedAndRemoveUntil(context, '/Home', (route) => false);
      break;

    case 'calendar':
      Navigator.pushNamed(context, '/Calender');
      break;

    case 'attendance':
      Navigator.pushNamed(context, '/Attendance');
      break;

    case 'today':
      Navigator.pushNamed(context, '/Today');
      break;

    case 'call':
      Navigator.pushNamed(context, '/Call');
      break;

    case 'dust':
      Navigator.pushNamed(context, '/Dust');
      break;

    default:
      Navigator.pushNamed(context, '/Ready');
      break;
  }
}

Widget drawerInfo({
  required String name,
  required String position,
  required String part,
}) {
  final List<String> info = [name, position, part];
  return Builder(
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ...info
              .map(
                (info) => Container(
                  width: MediaQuery.of(context).size.width / 3,
                  alignment: Alignment.centerLeft,
                  color: Colors.red[200],
                  child: Text(
                    info,
                  ),
                ),
              )
              .toList(),
        ],
      );
    },
  );
}
