import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_dust/util/data_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../database/hive_dust/hive_database.dart';
import 'card_title.dart';
import 'main_card.dart';

class HourlyCard extends StatelessWidget {
  const HourlyCard({
    required this.darkColor,
    required this.lightColor,
    required this.category,
    required this.stats,
    required this.region,
    Key? key,
  }) : super(key: key);

  final Color darkColor;
  final Color lightColor;
  final String category;
  final List<StatModel> stats;
  final String region;

  @override
  Widget build(BuildContext context) {
    return MainCard(
      backgroundColor: lightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTitle(
            title: '시간별 $category',
            backgroundColor: darkColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Column(
              children: stats
                  .map(
                    (stat) => renderRow(
                      stat: stat,
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget renderRow({required StatModel stat}) {
    final status = DataUtils.getStatusFromItemCodeAndValue(
      value: stat.getLevelFromRegion(region),
      itemCode: stat.itemCode,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 4.0,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${stat.dataTime.hour}시',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SvgPicture.asset(
              status.imagePath,
              height: 20.0,
            ),
          ),
          const Expanded(
            child: Text(
              '좋음',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
