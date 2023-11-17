import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:p_healthy/main.dart';
import 'package:p_healthy/service/noti_service.dart';

void getHeartBeatData() {
  try {
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('HeartBeat');
    starCountRef.onValue.listen(
      (DatabaseEvent event) async {
        final data = event.snapshot.value;
        heartBeat = int.parse(data.toString());
        if (heartBeat > 100 || heartBeat < 60) {
          ringNoti();
          warningType = "heart";
          FlutterOverlayWindow.showOverlay(
            enableDrag: true,
            overlayTitle: "X-SLAYER",
            overlayContent: 'Overlay Enabled',
            flag: OverlayFlag.defaultFlag,
            visibility: NotificationVisibility.visibilityPublic,
            positionGravity: PositionGravity.auto,
            height: 500,
            width: WindowSize.matchParent,
          );
        } else {
          // ringNoti();
          FlutterRingtonePlayer.stop();
        }
      },
    );
  } catch (e) {
    log(e.toString());
  }
}
