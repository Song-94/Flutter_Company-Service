import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_calendar/const/decorations.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({
    required this.startTime,
    required this.endTime,
    required this.content,
    required this.color,
    Key? key,
  }) : super(key: key);

  final int startTime;
  final int endTime;
  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultBoxDeco,
      margin: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: IntrinsicHeight(
            // 가장 높은 위젯의 높이 만큼 크기를 제한.
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Time(
                  startTime: startTime,
                  endTime: endTime,
                ),
                const SizedBox(width: 10.0),
                _Content(
                  content: content,
                ),
                const SizedBox(width: 10.0),
                _Category(
                  color: color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Time extends StatelessWidget {
  const _Time({
    required this.startTime,
    required this.endTime,
    Key? key,
  }) : super(key: key);

  final int startTime;
  final int endTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: defaultBoxDeco,
      child: Column(
        children: [
          Text(
            '${startTime.toString().padLeft(2, '0')}:00',
          ),
          Text('${endTime.toString().padLeft(2, '0')}:00'),
        ],
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.content,
    Key? key,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: defaultBoxDeco,
        child: Text(content),
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({
    required this.color,
    Key? key,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      width: 16.0,
      height: 16.0,
    );
  }
}
