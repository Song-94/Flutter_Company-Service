import 'package:flutter/material.dart';

import '../../../color/colors.dart';

class BottomSheetSaveButton extends StatelessWidget {
  const BottomSheetSaveButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: hex2color(PRIMARY_COLOR),
            ),
            child: const Text('저장'),
          ),
        ),
      ],
    );
  }
}
