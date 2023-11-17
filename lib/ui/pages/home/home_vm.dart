import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:p_healthy/model/enum/load_status.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeVM extends ChangeNotifier {
  final databaseReference = FirebaseDatabase.instance.ref();

  LoadStatus _fetchHeartBeatStatus = LoadStatus.initial;
  LoadStatus _fetchTemperatureStatus = LoadStatus.initial;
  LoadStatus _fetchSpO2Status = LoadStatus.initial;
  List<int> _heartBeats = [];
  List<int> _spO2s = [];
  int _spO2 = 0;
  int _heatBeat = 0;
  int _bodyTemp = 0;
  int _outsideTemp = 0;

  LoadStatus get fetchHeartBeatStatus => _fetchHeartBeatStatus;
  LoadStatus get fetchTemperatureStatus => _fetchTemperatureStatus;
  LoadStatus get fetchSpO2Status => _fetchSpO2Status;

  List<int> get heartBeats => _heartBeats;
  List<int> get spO2s => _spO2s;
  int get spO2 => _spO2;
  int get heartBeat => _heatBeat;
  int get bodyTemp => _bodyTemp;
  int get outsideTemp => _outsideTemp;

  Future<void> fetchHeatBeat() async {
    _fetchHeartBeatStatus = LoadStatus.success;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('HEARTRATE');
    starCountRef.onValue.listen(
      (DatabaseEvent event) {
        var result = <int>[];
        final data = event.snapshot.value;
        _heatBeat = int.parse(data.toString());
        result.add(int.parse(data.toString()));
        _heartBeats += result;
        log(_heatBeat.toString());
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> fetchSpO2() async {
    _fetchSpO2Status = LoadStatus.loading;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('SPO2');
    starCountRef.onValue.listen(
      (DatabaseEvent event) {
        var result = <int>[];
        final data = event.snapshot.value;
        _spO2 = int.parse(data.toString());
        result.add(_spO2);
        _spO2s += result;
        log(_spO2.toString());

        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> fetchBodyTemp() async {
    _fetchSpO2Status = LoadStatus.loading;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('ObjectTempC');
    starCountRef.onValue.listen(
      (DatabaseEvent event) {
        
        final data = event.snapshot.value;
        _bodyTemp = int.parse(data.toString());
        notifyListeners();
      },
    );
    notifyListeners();
  }

  Future<void> fetchOutsideTemp() async {
    _fetchSpO2Status = LoadStatus.loading;
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Temperature');
    starCountRef.onValue.listen(
      (DatabaseEvent event) {
        final data = event.snapshot.value;
        _outsideTemp = int.parse(data.toString());
      
        notifyListeners();
      },
    );
    notifyListeners();
  }
}
