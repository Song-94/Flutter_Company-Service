import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_dust/util/data_utils.dart';

import '../../database/hive_dust/model/stat_and_status_model.dart';
import 'card_title.dart';
import 'main_card.dart';
import 'main_stat.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    required this.region,
    required this.models,
    required this.darkColor,
    required this.lightColor,
    Key? key,
  }) : super(key: key);

  final String region;
  final List<StatAndStatusModel> models;
  final Color darkColor;
  final Color lightColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: MainCard(
        backgroundColor: lightColor,
        child: LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CardTitle(
                  title: '종류별 통계',
                  backgroundColor: darkColor,
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    physics: const PageScrollPhysics(),
                    children: models
                        .map(
                          (model) => MainStat(
                            category: DataUtils.getItemCodeKrString(
                              itemCode: model.itemCode,
                            ),
                            imgPath: model.status.imagePath,
                            level: model.status.label,
                            stat: '${model.stat.getLevelFromRegion(
                              region,
                            )}${DataUtils.getUnitFromItemCode(
                              itemCode: model.itemCode,
                            )}',
                            width: constraint.maxWidth / 3,
                          ),
                        )
                        .toList(),
                    // List.generate(
                    //   20,
                    //   (index) => MainStat(
                    //     category: '미세먼지',
                    //     imgPath: 'asset/img/best.png',
                    //     level: '최고',
                    //     stat: '$index㎍/m³',
                    //     width: constraint.maxWidth / 3,
                    //   ),
                    // ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
