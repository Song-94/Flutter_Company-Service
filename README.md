## Purpose

## Note

## Tips
1. apply font 
- https://velog.io/@adbr/flutter-font-%EC%A0%81%EC%9A%A9

2. .svg 벡터 이미지 package
- https://pub.dev/packages/flutter_svg/install

3. TextFormField Border
- 설정하지 않은 값들은 border 에 의해 자동으로 값이 설정 되기 때문에 각각 설정해야 함
- focusedBorder : 위젯 활성화 발생 시 테두리 스타일
- enabledBorder : 기본 상태의 테두리 스타일
* [InputDecoration.enabled], which is false if the [InputDecorator] is disabled.
* [InputDecoration.errorText], the error shown by the [InputDecorator], if non-null.
* [border], for a description of where the [InputDecorator] border appears.
* [UnderlineInputBorder], an [InputDecorator] border which draws a horizontal
  line at the bottom of the input decorator's container.
* [OutlineInputBorder], an [InputDecorator] border which draws a
  rounded rectangle around the input decorator's container.
* [InputBorder.none], which doesn't draw a border.
* [errorBorder], displayed when [InputDecorator.isFocused] is false
  and [InputDecoration.errorText] is non-null.
* [focusedBorder], displayed when [InputDecorator.isFocused] is true
  and [InputDecoration.errorText] is null.
* [focusedErrorBorder], displayed when [InputDecorator.isFocused] is true
  and [InputDecoration.errorText] is non-null.
* [disabledBorder], displayed when [InputDecoration.enabled] is false
  and [InputDecoration.errorText] is null.

4. TextFormField 입력 값
https://chinpa.tistory.com/83

5. build 메소드 역할
- Builder 클래스는 내부 위젯들을 새로운 위젯으로 강제적으로 만들며 
  그 부모(여기선 Scaffold)의 context로 접근가능하게 만들어줍니다. 
  하지만 새로운 Widget class를 구현하는 것은 재사용성 측면에서 매우 뛰어날뿐만 아니라 
  가독성과 깔끔함까지 같이 가져갈 수 있습니다.
- https://velog.io/@rokwon_k/Flutter-Widget%EC%9D%98-%ED%83%80%EC%9E%85%EA%B3%BC-BuildContext

6. ListView 와 ListTile 을 사용하여 사이드 메뉴 리스트를 추가했습니다.
- ListView 는 항목들을 행으로 나열합니다.
  ListTile 은 각 항목에 대한 열의 항목들(아이콘, 텍스트 등)을 나열합니다.

7. flutter Navigator Stack 지우기
https://m.blog.naver.com/PostView.naver?blogId=chandong83&logNo=221948462147&proxyReferer=

8. Language Setting
- import 'package:intl/date_symbol_data_file.dart';  = 언어 파일의 위치 설정
- import 'package:intl/date_symbol_data_local.dart'; = 언어 설정.

9. Listview
- https://jvvp.tistory.com/1127

10. Dialog 내부 builder
- https://changjoopark.medium.com/flutter-dialog-%EC%95%88%EC%97%90%EC%84%9C-%EC%B2%B4%ED%81%AC%EB%B0%95%EC%8A%A4%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%98%EB%A0%A4%EB%A9%B4-d14258165d58

11. Column, Widget AxisAlign
- https://beomseok95.tistory.com/310

12. DexArchiveMergerException 에러 해결 용 코드
- multiDexEnabled true
- implementation 'com.android.support:multidex:2.0.1'

## version
1. flutter version 3.3
2. ext.kotlin_version = '1.5.0'

## Q&A

## Functions
1. 달력
- https://pub.dev/packages/table_calendar
3. 출석체크
- https://pub.dev/packages/google_maps_flutter
3. 날씨
4. 미세먼지
5. 배달
6. Agora API 영상통화
-  https://www.agora.io/en/products/video-call/
8. Agora API 음성 기능
- https://www.agora.io/en/products/voice-call/
8. Agora API 채팅 기능
- https://www.agora.io/en/products/chat/

## calendar styling
- https://stackoverflow.com/questions/66992384/adding-divider-in-flutter-calendar-widget-after-weekdays
- https://dalgoodori.tistory.com/17

## Error Resolved
How to Solve Execution failed for task ‘:geolocator_android:compileDebugJavaWithJavac’ in flutter Error?
Solution 1: Change compileSDKVersion from 29 to 31 
-> But, permission_handler_android must need SDKVersion higher than 33.
Solution 2: Downgrade geolocator 6.2.1

## Dart Exception Process
- https://sualchi.tistory.com/13721154

## FirebaseAuth kind of exception
- https://stackoverflow.com/questions/67617502/what-are-the-error-codes-for-flutter-firebase-auth-exception

## Future / async / await
- https://dkswnkk.tistory.com/24

## keyboard active [KeyboardVisibilityBuilder]
- https://dev-nam.tistory.com/30

## Firebase useful functions
- https://beomseok95.tistory.com/108
- https://papabee.tistory.com/335

## Firebase basic structure
- https://firebase.google.com/docs/rules/rules-language?hl=ko#storage