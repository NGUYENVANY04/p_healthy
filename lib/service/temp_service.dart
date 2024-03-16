import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:p_healthy/main.dart';
import 'package:p_healthy/service/noti_service.dart';

void getTempData() {
  try {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('ObjectTempC');
    starCountRef.onValue.listen(
      (DatabaseEvent event) async {
        final data = event.snapshot.value;
        temp = int.parse(data.toString());
        if (temp > 38 || temp < 36) {
          ringNoti();
          warningType = "temp";
          FlutterOverlayWindow.showOverlay(
            enableDrag: true,
            overlayTitle: "Body temperature",
            overlayContent: 'Body temperature',
            flag: OverlayFlag.defaultFlag,
            visibility: NotificationVisibility.visibilityPublic,
            positionGravity: PositionGravity.auto,
            height: 500,
            width: WindowSize.matchParent,
          );
        } else {
          FlutterRingtonePlayer.stop();
        }
      },
    );
  } catch (e) {
    log(e.toString());
  }
}
