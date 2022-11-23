import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../database/drift_calendar/drift_database.dart';
import 'bottom_sheet/color_picker.dart';
import 'bottom_sheet/content.dart';
import 'bottom_sheet/save_button.dart';
import 'bottom_sheet/time.dart';

class ScheduleBottomSheet extends StatefulWidget {
  const ScheduleBottomSheet({
    required this.selectedDate,
    this.scheduleId,
    Key? key,
  }) : super(key: key);

  final DateTime selectedDate;
  final int? scheduleId;

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  int? selectedColorId;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: FutureBuilder<Schedule>(
          future: widget.scheduleId == null
              ? null
              : GetIt.I<LocalDatabase>().getScheduleById(widget.scheduleId!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('스케줄을 불러올 수 없습니다.'),
              );
            }

            if (snapshot.connectionState != ConnectionState.none &&
                !snapshot.hasData) {
              // FutureBuilder 가 처음 실행됬고, 로딩 중일때.
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasData && startTime == null) {
              // Future 가 실행이 되고
              // 값이 존재하는데 단 한번도 startTime 이 세팅 되지 않았을 때
              startTime = snapshot.data!.startTime;
              endTime = snapshot.data!.endTime;
              content = snapshot.data!.content;
              selectedColorId = snapshot.data!.colorId;
            }

            return SafeArea(
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2 + bottomInset,
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 16.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BottomSheetTime(
                            onStartSaved: (String? val) =>
                                startTime = int.parse(val!),
                            onEndSaved: (String? val) =>
                                endTime = int.parse(val!),
                            startInitialValue: startTime?.toString() ?? '',
                            endInitialValue: endTime?.toString() ?? '',
                          ),
                          const SizedBox(height: 16.0),
                          BottomSheetContent(
                            onSaved: (String? val) => content = val,
                            initialValue: content ?? '',
                          ),
                          const SizedBox(height: 16.0),
                          FutureBuilder<List<CategoryColor>>(
                            future:
                                GetIt.I<LocalDatabase>().getCategoryColors(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  selectedColorId == null &&
                                  snapshot.data!.isNotEmpty) {
                                selectedColorId = snapshot.data![0].id;
                              }
                              return BottomSheetColorPicker(
                                colors: snapshot.hasData ? snapshot.data! : [],
                                selectedColorId: selectedColorId,
                                colorIdSetter: (int id) {
                                  setState(() {
                                    selectedColorId = id;
                                  });
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16.0),
                          BottomSheetSaveButton(
                            onPressed: onSavePressed,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  void onSavePressed() async {
    if (formKey.currentState == null) {
      // formKey 는 생성했지만, Form 위젯과는 결합을 안했을 때.
      return;
    }

    // validate() 역할 : Form 아래 있는 모든 텍스트 폼 필드들의 'validator' 가 실행 됨.
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      if (widget.scheduleId == null) {
        await GetIt.I<LocalDatabase>().createSchedule(SchedulesCompanion(
          content: Value(content!),
          date: Value(widget.selectedDate),
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          colorId: Value(selectedColorId!),
        ));
      } else {
        await GetIt.I<LocalDatabase>().updateScheduleById(
            widget.scheduleId!,
            SchedulesCompanion(
              content: Value(content!),
              date: Value(widget.selectedDate),
              startTime: Value(startTime!),
              endTime: Value(endTime!),
              colorId: Value(selectedColorId!),
            ));
      }

      Navigator.of(context).pop();
    } else {
      print('에러가 있습니다.');
    }
  }
}
