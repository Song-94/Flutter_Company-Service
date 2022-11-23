import 'package:flutter/material.dart';

class StatusModel {
  StatusModel({
    required this.level, // 단계
    required this.label, // 단계 이름
    required this.primaryColor, // 주 색상
    required this.darkColor, // 어두운 색상
    required this.lightColor, // 밝은 색상
    required this.detailFontColor, // 폰트 색상
    required this.imagePath, // 이모티콘 이미지 패스
    required this.comment, // 코멘트
    required this.minFineDust, // 미세먼지 최소치
    required this.minUltraFineDust, // 초미세먼지 최소치
    required this.minO3, // 오존 최소치
    required this.minNO2, // 이산화질소 최소치
    required this.minCO, // 일산화탄소 최소치
    required this.minSO2, // 아황산가스 최소치
  });

  final int level; // 단계
  final String label; // 단계 이름
  final Color primaryColor; // 주 색상
  final Color darkColor; // 어두운 색상
  final Color lightColor; // 밝은 색상
  final Color detailFontColor; // 폰트 색상
  final String imagePath; // 이모티콘 이미지 패스
  final String comment; // 코멘트
  final double minFineDust; // 미세먼지 최소치
  final double minUltraFineDust; // 초미세먼지 최소치
  final double minO3; // 오존 최소치
  final double minNO2; // 이산화질소 최소치
  final double minCO; // 일산화탄소 최소치
  final double minSO2; // 아황산가스 최소치
}