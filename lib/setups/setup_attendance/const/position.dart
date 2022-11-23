import 'package:google_maps_flutter/google_maps_flutter.dart';

const double okDistance = 100;

// latitude - 위도, longitude - 경도
const LatLng companyLatLng = LatLng(
  37.3690,
  126.8120,
  // 126.8130,
);

const CameraPosition initialPosition = CameraPosition(
  target: companyLatLng,
  zoom: 15,
);