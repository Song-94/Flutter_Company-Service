import 'package:flutter/material.dart';
import 'package:flutter_company_service/textstyle/textstyle.dart';

class TopPart extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;

  const TopPart({
    required this.selectedDate,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Our Crew',
            style: todayScreenTitle,
          ),
          Column(
            children: [
              Text(
                '입사일로부터...',
                style: defaultFont,
              ),
              Text(
                '${selectedDate.year}.${selectedDate.month}.${selectedDate
                    .day}',
                style: defaultFont,
              ),
            ],
          ),
          IconButton(
            iconSize: 60.0,
            onPressed: onPressed,
            icon: const Icon(
              Icons.exit_to_app_outlined,
              color: Colors.green,
            ),
          ),
          Text(
            'D+${DateTime(
              now.year,
              now.month,
              now.day,
            )
                .difference(selectedDate)
                .inDays + 1}',
            style: defaultFont,
          ),
        ],
      ),
    );
  }
}