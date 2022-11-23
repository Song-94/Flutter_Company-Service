import 'package:flutter/material.dart';

Color hex2color(String hexCode) {
  return Color(
    int.parse(
      'FF$hexCode',
      radix: 16,
    ),
  );
}

const PRIMARY_COLOR = 'A3E7D6';

const SCHEDULE_COLORS = [
  // 빨강
  'F44336',
  // 주황
  'FF9800',
  // 노랑
  'FFEB3B',
  // 초록
  'FCAF50',
  // 파랑
  '2196F3',
  // 남색
  '3F51B5',
  // 보라
  '9C27B0',
];
