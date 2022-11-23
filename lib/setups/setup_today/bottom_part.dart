import 'package:flutter/material.dart';
import 'package:flutter_company_service/path/image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomPart extends StatelessWidget {
  const BottomPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SvgPicture.asset(
        TODAY_SCREEN_MAIN,
      ),
    );
  }
}
