import 'package:agora_rtc_engine/rtc_engine.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;

import 'const/data.dart';


class CamScreen extends StatefulWidget {
  const CamScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CamScreenState createState() => _CamScreenState();
}

class _CamScreenState extends State<CamScreen> {
  RtcEngine? engine;
  int? uid;
  int? otherUid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LIVE'),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    renderMainView(),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        color: Colors.grey,
                        height: 160,
                        width: 120,
                        child: renderSubView(),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (engine != null) {
                    await engine!.leaveChannel();
                    await engine!.destroy();
                  }

                  Navigator.of(context).pop();
                },
                child: Text('채널 나가기'),
              )
            ],
          );
        },
      ),
    );
  }

  Widget renderSubView() {
    if (otherUid == null) {
      return Center(
        child: Text('채널에 유저가 없습니다.'),
      );
    } else {
      return RtcRemoteView.SurfaceView(
        uid: otherUid!,
        channelId: CHANNEL_NAME,
      );
    }
  }

  Widget renderMainView() {
    if (uid == null) {
      return Center(
        child: Text('채널에 참여해주세요'),
      );
    } else {
      return RtcLocalView.SurfaceView(); // if no channels, Black screen
    }
  }

  Future<bool> init() async {
    final res = await [Permission.camera, Permission.microphone].request();

    final cameraPermission = res[Permission.camera];
    final micPermission = res[Permission.microphone];

    if (cameraPermission != PermissionStatus.granted ||
        micPermission != PermissionStatus.granted) {
      print(res);
      throw '카메라 또는 마이크 권한이 없습니다.';
    }

    if (engine == null) {
      RtcEngineContext context = RtcEngineContext(APP_ID);

      engine = await RtcEngine.createWithContext(context);
      engine!.setEventHandler(
        RtcEngineEventHandler(
          joinChannelSuccess: (String channel, int uid, int elapsed) {
            // When I join a channel
            // elapsed: The time it takes to join
            print('채널에 입장했습니다. uid[$uid]');
            setState(() {
              this.uid = uid;
            });
          },
          leaveChannel: (state) {
            print('채널 퇴장');
            setState(() {
              uid = null;
            });
          },
          userJoined: (int uid, int elapsed) {
            print('상대가 채널에 입장했습니다. uid[$uid]');
            setState(() {
              otherUid = uid;
            });
          },
          userOffline: (int uid, UserOfflineReason reason) {
            if (reason == UserOfflineReason.Quit) {
              print('상대가 채널에서 나갔습니다. uid[$uid]');
            } else if (reason == UserOfflineReason.Dropped) {
              print('상대 네트워크가 불안정 합니다. uid[$uid]');
            }
            setState(() {
              otherUid = null;
            });
          },
        ),
      );

      // Video(Camera) activate
      await engine!.enableVideo();
      // Join the channel
      await engine!.joinChannel(
        TEMP_TOKEN,
        CHANNEL_NAME,
        null,
        0,
      );
    }

    return true;
  }
}
