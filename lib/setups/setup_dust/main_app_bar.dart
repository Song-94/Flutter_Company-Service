import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_dust/const/regions.dart';
import 'package:flutter_company_service/setups/setup_dust/util/data_utils.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';
import 'package:flutter_svg/svg.dart';

import '../../database/hive_dust/hive_database.dart';
import '../../database/hive_dust/model/status_model.dart';

typedef OnRegionTap = void Function(String region);

class MainAppBar extends StatelessWidget {
  MainAppBar({
    required this.region,
    required this.stat,
    required this.status,
    required this.dateTime,
    required this.isExpanded,
    required this.onRegionTap,
    Key? key,
  }) : super(key: key);

  final String region;
  final StatModel stat; // API 받아오는 실제 값
  final StatusModel status; // 기준이 되는 수치
  final DateTime dateTime;
  final bool isExpanded;
  final OnRegionTap onRegionTap;

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      automaticallyImplyLeading: false, // leading button hide
      backgroundColor: status.primaryColor,
      pinned: true, // pinned is true, title is always show.
      title: isExpanded
          ? null
          : Text(
              '$region ${DataUtils.getTimeFromDateTime(dateTime: dateTime)}',
            ),
      centerTitle: true,
      expandedHeight: 550,
      flexibleSpace: FlexibleSpaceBar(
        // scroll 해서 보였다 안보였다 가능.
        background: Container(
          // padding : Column 과의 거리 간격을 벌리는 것, 컨테이너 내부를 수정.
          margin:
              const EdgeInsets.only(top: kToolbarHeight), // SafeArea 와의 간격 벌림.
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () async {
                  showDialogRegions(context);
                },
                icon: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.redAccent,
                ),
                label: Text(
                  region,
                  style: defaultFont.copyWith(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                DataUtils.getTimeFromDateTime(dateTime: stat.dataTime),
                style: defaultFont.copyWith(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SvgPicture.asset(
                status.imagePath,
                height: MediaQuery.of(context).size.width / 2,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                status.label,
                style: defaultFont.copyWith(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.yellow,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                status.comment,
                style: defaultFont.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.lightGreenAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget?> showDialogRegions(BuildContext context) {
    return showDialog<Widget>(
        barrierDismissible: true, // other space click, dismiss dialog
        context: context,
        builder: (_) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                ),
                child: ListView.builder(
                    itemCount: regions.length,
                    itemBuilder: (_, index) {
                      return TextButton.icon(
                        onPressed: () {
                          onRegionTap(regions[index]);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        icon: (region == regions[index])
                            ? const Icon(Icons.check_box_outlined)
                            : const Icon(Icons.check_box_outline_blank_sharp),
                        label: Text(regions[index]),
                      );
                    }),
              ),
            ],
          );
        });
  }
}
