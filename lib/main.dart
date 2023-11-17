import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:p_healthy/app.dart';
import 'package:p_healthy/service/firebase_options.dart';
import 'package:p_healthy/service/heart_beat_service.dart';
import 'package:p_healthy/service/temp_service.dart';
import 'package:p_healthy/ui/common/heart_beat_overlay.dart';
import 'package:p_healthy/ui/common/temp_overlay.dart';

bool isInternet = true;
bool? isLogin = false;
String warningType = "";
int temp = 0;
int heartBeat = 0;
double currentLat = 0;
double currentLon = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  checkPermission();
  getHeartBeatData();
  getTempData();
  _getLocation();
  runApp(const MyApp());
}

@pragma("vm:entry-point")
void overlayMain() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: warningType == "temp"
          ? const TempOverlay()
          : const HeartBeatOverlay(),
    ),
  );
}

Future<void> checkPermission() async {
  final status = await FlutterOverlayWindow.isPermissionGranted();
  if (!status) {
    FlutterOverlayWindow.requestPermission();
  }
}

void _getLocation() {
  DatabaseReference latRef = FirebaseDatabase.instance.ref('Latitude');
  DatabaseReference lonRef = FirebaseDatabase.instance.ref('Longitude');

  latRef.onValue.listen(
    (DatabaseEvent event) {
      final data = event.snapshot.value;
      currentLat = double.parse(data.toString());
    },
  );
  lonRef.onValue.listen(
    (DatabaseEvent event) {
      final data = event.snapshot.value;
      currentLon = double.parse(data.toString());
    },
  );
}
