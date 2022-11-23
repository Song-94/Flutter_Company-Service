import 'package:geolocator/geolocator.dart';

// AndroidManifest.xml add under contents.
// <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
// <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
// <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />

Future<String> checkPermission() async {
  // 휴대폰 위치 권한 유/무 확인
  final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
  if (!isLocationEnabled) {
    return '위치 서비스를 활성화 해주세요.';
  }

  // 앱의 위치 서비스에 대한 권한
  // denied : 맨 처음 앱을 켰을 때의 기본 값 : Geolocator.requestPermission() 요청 해야함.
  // deniedForever : 이 앱에서 절대적으로 권한 요청이 불가
  // whileInUse : 앱 실행 중에만 권한 허용
  // always : 항상 허용

  final checkedPermission = await Geolocator.checkPermission();

  if (checkedPermission == LocationPermission.denied) {
    await Geolocator.requestPermission();

    if (checkedPermission == LocationPermission.denied) {
      return '위치 권한을 허가해주세요.';
    }
  }
  if (checkedPermission == LocationPermission.deniedForever) {
    return '앱의 위치 권한을 세팅에서 허가해주세요.';
  }
  return '위치 권한을 허가되었습니다.';
}