import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_attendance/const/position.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Circle withinDistanceCircle = Circle(
  circleId: const CircleId('WithinDistanceCircle'),
  center: companyLatLng,
  fillColor: Colors.blue.withOpacity(0.5), // 원의 색
  radius: okDistance, // 원의 반지름
  strokeColor: Colors.blue, // 원의 둘레 색상
  strokeWidth: 1, // 원의 둘레 너비
);

Circle notWithinDistanceCircle = Circle(
  circleId: const CircleId('notWithinDistanceCircle'),
  center: companyLatLng,
  fillColor: Colors.red.withOpacity(0.5), // 원의 색
  radius: okDistance, // 원의 반지름
  strokeColor: Colors.red, // 원의 둘레 색상
  strokeWidth: 1, // 원의 둘레 너비
);

Circle checkDoneCircle = Circle(
  circleId: const CircleId('checkDoneCircle'),
  center: companyLatLng,
  fillColor: Colors.green.withOpacity(0.5), // 원의 색
  radius: okDistance, // 원의 반지름
  strokeColor: Colors.green, // 원의 둘레 색상
  strokeWidth: 1, // 원의 둘레 너비
);

const Marker marker = Marker(
  markerId: MarkerId('marker'),
  position: companyLatLng,
);
