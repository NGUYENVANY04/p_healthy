import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:p_healthy/main.dart';
import 'package:p_healthy/service/noti_service.dart';

class HeartBeatOverlay extends StatefulWidget {
  const HeartBeatOverlay({Key? key}) : super(key: key);

  @override
  State<HeartBeatOverlay> createState() => _HeartBeatOverlayState();
}

class _HeartBeatOverlayState extends State<HeartBeatOverlay> {
  bool isGold = true;

  final _goldColors = const [
    Color(0xFFa2790d),
    Color(0xFFebd197),
    Color(0xFFa2790d),
  ];

  final _silverColors = const [
    Color(0xFFAEB2B8),
    Color(0xFFC7C9CB),
    Color(0xFFD7D7D8),
    Color(0xFFAEB2B8),
  ];

  @override
  void initState() {
    super.initState();
    FlutterOverlayWindow.overlayListener.listen((event) {
      log("$event");
      setState(() {
        isGold = !isGold;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log(warningType);
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isGold ? _goldColors : _silverColors,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: GestureDetector(
            onTap: () {
              FlutterOverlayWindow.shareData("Body");
            },
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                        title: const Text(
                          "Warning",
                          style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        ),
                        subtitle: Text(
                          heartBeat > 100
                              ? "Your body temperature is higher than the safe level. - $heartBeat"
                              : "Your body temperature is lower than the safe level. - $heartBeat",
                          style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )),
                    const Spacer(),
                    const Divider(color: Colors.black54),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    onPressed: () async {
                      await FlutterOverlayWindow.closeOverlay();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
