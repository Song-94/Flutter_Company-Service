import 'package:flutter/material.dart';

class CheckInButton extends StatelessWidget {
  final bool isWithinRange;
  final VoidCallback onPressed;
  final bool checkInDone;

  const CheckInButton({
    required this.isWithinRange,
    required this.onPressed,
    required this.checkInDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timelapse_outlined,
            size: 50.0,
            color: checkInDone
                ? Colors.green
                : isWithinRange
                ? Colors.blue
                : Colors.red,
          ),
          const SizedBox(
            height: 20.0,
          ),
          if (!checkInDone && isWithinRange)
            TextButton(
              onPressed: onPressed,
              child: const Text(
                '출근하기',
              ),
            )
        ],
      ),
    );
  }
}
