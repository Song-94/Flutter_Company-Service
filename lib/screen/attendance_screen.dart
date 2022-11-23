import 'package:flutter/material.dart';
import 'package:flutter_company_service/setups/setup_attendance/attendance.dart';
import 'package:flutter_company_service/permission/gps.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../setups/setup_attendance/check-in_button.dart';
import '../setups/setup_attendance/const/figure.dart';
import '../setups/setup_attendance/const/position.dart';
import '../component/appbar.dart';
import '../component/drawer.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool checkInDone = false;
  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawerEnableOpenDragGesture: false,
      appBar: commonAppBar(title: 'AttendanceScreen', context: context),
      drawer: commonDrawer(context: context),
      backgroundColor: Colors.white,
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.data);

          if (snapshot.hasData || snapshot.hasError) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == '위치 권한을 허가되었습니다.') {
              return streamGoogleMap();
            }
          }

          return Center(
            child: snapshot.hasData
                ? Text(snapshot.data)
                : const CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  StreamBuilder streamGoogleMap() {
    return StreamBuilder<Position>(
      stream: Geolocator.getPositionStream(),
      builder: (context, snapshot) {
        bool isWithinRange = false;

        if (snapshot.hasData) {
          final Position start = snapshot.data!;
          const LatLng end = companyLatLng;

          final distance = Geolocator.distanceBetween(
            start.latitude,
            start.longitude,
            end.latitude,
            end.longitude,
          );

          if (distance < okDistance) {
            isWithinRange = true;
          }
        }

        return Column(
          children: [
            MyAttendance(
              initialPosition: initialPosition,
              circle: checkInDone
                  ? checkDoneCircle
                  : isWithinRange
                      ? withinDistanceCircle
                      : notWithinDistanceCircle,
              marker: marker,
              onMapCreated: _onMapCreated,
            ),
            CheckInButton(
              isWithinRange: isWithinRange,
              onPressed: _onCheckInPressed,
              checkInDone: checkInDone,
            ),
          ],
        );
      },
    );
  }

  void _onCheckInPressed() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('출근하기'),
          content: const Text('출근을 하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('출근하기'),
            ),
          ],
        );
      },
    );

    if (result) {
      setState(() {
        checkInDone = true;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }
}
