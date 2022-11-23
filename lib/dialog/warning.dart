import 'package:flutter/material.dart';

Future warningDialog({
  required BuildContext context,
  required String err,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: const Icon(
          Icons.warning_amber_rounded,
          color: Colors.red,
        ),
        title: const Text('Error'),
        content: Text('Detail : $err'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          )
        ],
      );
    },
  );
}
