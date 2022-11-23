import 'package:flutter/material.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainStat extends StatelessWidget {
  const MainStat({
    required this.category,
    required this.imgPath,
    required this.level,
    required this.stat,
    required this.width,
    Key? key,
  }) : super(key: key);

  final String category; // 미세먼지 종류
  final String imgPath; // 아이콘 위치 (경로)
  final String level; // 오염 정도
  final String stat; // 오염 수치

  final double width; // 너비


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            category,
            style: defaultFont.copyWith(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8.0),
          SvgPicture.asset(
            imgPath,
            width: 50.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            level,
            style: defaultFont.copyWith(
              fontSize: 12.0,
              color: Colors.indigoAccent,
            ),
          ),
          Text(
            stat,
            style: defaultFont.copyWith(
              fontSize: 12.0,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
    );
  }
}
