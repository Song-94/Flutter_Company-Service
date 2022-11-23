import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyAttendance extends StatelessWidget {
  final CameraPosition initialPosition;
  final Circle circle;
  final Marker marker;
  final MapCreatedCallback onMapCreated;

  const MyAttendance({
    required this.initialPosition,
    required this.circle,
    required this.marker,
    required this.onMapCreated,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        circles: Set.from([circle]),
        markers: Set.from([marker]),
        onMapCreated: onMapCreated,
      ),
    );
  }
}
