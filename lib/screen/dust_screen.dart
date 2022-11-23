import 'package:flutter/material.dart';
import 'package:flutter_company_service/component/appbar.dart';
import 'package:flutter_company_service/component/drawer.dart';

import '../database/hive_dust/hive_database.dart';
import '../database/hive_dust/model/stat_and_status_model.dart';
import '../setups/setup_dust/category_card.dart';
import '../setups/setup_dust/const/regions.dart';
import '../setups/setup_dust/hourly_card.dart';
import '../setups/setup_dust/main_app_bar.dart';
import '../setups/setup_dust/repository/stat_repository.dart';
import '../setups/setup_dust/util/data_utils.dart';

class DustScreen extends StatefulWidget {
  const DustScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DustScreen> createState() => _DustScreenState();
}

class _DustScreenState extends State<DustScreen> {
  String region = regions[0];
  bool isExpanded = true;
  ScrollController scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    scrollController.addListener(funcScrollListener);
  }

  @override
  dispose() {
    scrollController.removeListener(funcScrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<Map<ItemCode, List<StatModel>>> fetchData() async {
    Map<ItemCode, List<StatModel>> stats = {};

    List<Future> futures = [];

    for (ItemCode itemCode in ItemCode.values) {
      futures.add(
        // await fetchData 하면 값이 돌아올 때 까지 기다리지만, await 를 붙이지 않으면
        // 기다리지 않고 바로 다음 루프를 돈다.
        StatRepository.fetchData(
          itemCode: itemCode,
        ),
      );
    }

    final results =
        await Future.wait(futures); // List 안에 있는 Future 함수를 한번에 기다림.

    for (int i = 0; i < results.length; i++) {
      final key = ItemCode.values[i];
      final value = results[i];

      stats.addAll({
        key: value,
      });
    }

    return stats;
  }

  void funcScrollListener() {
    bool isExpanded =
        scrollController.offset < 500 - kToolbarHeight; // 스크롤 한 위치.
    if (isExpanded != this.isExpanded) {
      setState(() {
        this.isExpanded = isExpanded;
      });
    }
  }

  void funcScroll2Top() {
    // scrollController.animateTo(
    //   0,
    //   duration: const Duration(
    //     seconds: 1,
    //   ),
    //   curve: Curves.linear,
    // ); // slide move to top
    scrollController.jumpTo(0); // direct move top
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<ItemCode, List<StatModel>>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: commonAppBar(title: 'DustScreen', context: context),
            drawer: commonDrawer(context: context),
            body: const Center(
              child: Text(
                '에러가 있습니다.',
              ),
            ),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: commonAppBar(title: 'DustScreen', context: context),
            drawer: commonDrawer(context: context),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        Map<ItemCode, List<StatModel>> stats = snapshot.data!;
        StatModel pm10RecentStat = stats[ItemCode.PM10]![0];

        // 미세먼지 최근 데이터의 현재 상태
        final status = DataUtils.getStatusFromItemCodeAndValue(
          value: pm10RecentStat.seoul,
          itemCode: ItemCode.PM10,
        );

        final ssModel = stats.keys.map((key) {
          final value = stats[key]!;
          final stat = value[0];

          return StatAndStatusModel(
            itemCode: key,
            status: DataUtils.getStatusFromItemCodeAndValue(
              value: stat.getLevelFromRegion(region),
              itemCode: key,
            ),
            stat: stat,
          );
        }).toList();

        return Scaffold(
          appBar: commonAppBar(title: 'DustScreen', context: context),
          drawer: commonDrawer(context: context),
          drawerEnableOpenDragGesture: false,
          resizeToAvoidBottomInset: false,
          body: Container(
            color: status.primaryColor,
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainAppBar(
                  isExpanded: isExpanded,
                  region: region,
                  stat: pm10RecentStat,
                  status: status,
                  dateTime: pm10RecentStat.dataTime,
                  onRegionTap: selectRegion,
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CategoryCard(
                        region: region,
                        models: ssModel,
                        darkColor: status.darkColor,
                        lightColor: status.lightColor,
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ...stats.keys.map(
                        (itemCode) {
                          final stat = stats[itemCode]!;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: HourlyCard(
                              category: DataUtils.getItemCodeKrString(
                                itemCode: itemCode,
                              ),
                              region: region,
                              stats: stat,
                              darkColor: status.darkColor,
                              lightColor: status.lightColor,
                            ),
                          );
                        },
                      ).toList(),
                      const SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: isExpanded
              ? null
              : FloatingActionButton(
                  onPressed: funcScroll2Top,
                  child: const Icon(Icons.arrow_upward),
                ),
        );
      },
    );
  }

  void selectRegion(String region) {
    setState(() {
      this.region = region;
    });

    Navigator.of(context).pop(); // 화면에서 뒤로 가기 (Drawer one of Screen)
  }
}
