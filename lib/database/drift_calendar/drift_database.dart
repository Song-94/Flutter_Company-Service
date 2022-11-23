import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'model/category_color.dart';
import 'model/schedule.dart';
import 'model/schedule_with_color.dart';

// code generation
part 'drift_database.g.dart';

@DriftDatabase(
// 인스턴스로 만들지 않고 타입 선언으로.
  tables: [
    Schedules,
    CategoryColors,
  ],
)

class LocalDatabase extends _$LocalDatabase {
  // 제너레이션 후 _$LocalDatabase 클래스에 QueryExecutor 생성자 파라미터가 필요함
  LocalDatabase() : super(_openConnection());

  // [C] Create Data
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  // [R] Read Data
  // 내부 함수 앞 '..' => 클래스의 인스턴스를 셋팅한다
  // 하나만 있는지 확인하고 해당 요소를 반환합니다.
  // 비어 있거나 둘 이상의 요소가 있는 경우 [StateError]가 발생
  Future<Schedule> getScheduleById(int id) =>
      (select(schedules)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();

  // [U] Update Data
  Future<int> updateScheduleById(int id, SchedulesCompanion data) =>
      (update(schedules)..where((tbl) => tbl.id.equals(id))).write(data);

  // [D] Delete Data
  Future<int> removeSchedule(int id) =>
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  Stream<List<ScheduleWithColor>> watchSchedules(DateTime date) {
    // equalsExp : 이 표현식이 주어진 표현식과 같은지 여부입니다.
    // innerJoin(other, on)
    // other : select 한 테이블과 비교할 다른테이블,
    // on : join 하는 condition
    // schedules 과 categoryColors 를 join 을 하는데,
    // categoryColors.id 가 schedules.colorId 와 같은지

    final query = select(schedules).join([
      innerJoin(
        categoryColors,
        categoryColors.id.equalsExp(schedules.colorId),
      ),
    ]);

    query.where(schedules.date.equals(date));
    query.orderBy(
      [
        // asc  -> ascending 오름차순
        // desc -> descending 내림차순
        OrderingTerm.asc(schedules.startTime),
      ],
    );

    // .watch() 모든 data 값 볼 수 있음.
    // rows = filtering 된 모든 값.
    return query.watch().map(
          (rows) => rows
              .map(
                (row) => ScheduleWithColor(
                  schedule: row.readTable(schedules),
                  categoryColor: row.readTable(categoryColors),
                ),
              )
              .toList(),
        );
  }

  @override
  // TODO: implement schemaVersion
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // App 설치 시, OS 에서 App 별로 각각 사용할 수 있는 하드 드라이브에 위치를 지정해줌.
    // 그 위치를 받을 수 있는 API : getApplicationDocumentsDirectory [path_provider]

    final dbFolder = await getApplicationDocumentsDirectory();

    //  해당 경로에 파일 생성.
    final file =
        File(p.join(dbFolder.path, 'db.sqlite')); // dart:html 웹에서 사용 하는 것.

    return NativeDatabase(file);
  });
}
