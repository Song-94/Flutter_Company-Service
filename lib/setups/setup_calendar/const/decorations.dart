import 'package:flutter/material.dart';

final defaultBoxDeco = BoxDecoration(
  color: Colors.cyan,
  borderRadius: BorderRadius.circular(10.0),
);

final selectBoxDeco = BoxDecoration(
  color: Colors.purple,
  borderRadius: BorderRadius.circular(6.0),
  border: Border.all(
    color: Colors.grey,
    width: 1.0,
  ),
);

const outsideBoxDeco = BoxDecoration(
  shape: BoxShape.rectangle,
);