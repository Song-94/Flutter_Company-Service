import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// color == null || foreground == null
TextStyle loginScreenTitle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 40,
  wordSpacing: 1.5,
  foreground: Paint() // 그라데이션
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0
    ..color = Colors.black,
);

TextStyle todayScreenTitle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 40,
  wordSpacing: 1.5,
  foreground: Paint() // 그라데이션
    ..shader = ui.Gradient.linear(
      const Offset(0, 20),
      const Offset(300, 20),
      <Color>[Colors.red, Colors.greenAccent],
    ),
);

const TextStyle defaultFont = TextStyle(
  fontSize: 20,
  color: Colors.black,
);
