import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class HeartBeatChart extends StatefulWidget {
  const HeartBeatChart({super.key, required this.heartBeat});

  final List<int> heartBeat;

  @override
  State<HeartBeatChart> createState() => _HeartBeatChartState();
}

class _HeartBeatChartState extends State<HeartBeatChart> {
  List<SalesData> chartData = [];

  @override
  void initState() {
    super.initState();
    log("check heartBeat +${widget.heartBeat.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    chartData = convertToSalesDataList(widget.heartBeat);
    // log("check chart data +${chartData[0].toString()}");
    return Scaffold(
      body: Center(
        child: SfCartesianChart(
          primaryXAxis: NumericAxis(),
          series: <ChartSeries>[
            LineSeries<SalesData, int>(
                dataSource: chartData,
                xValueMapper: (SalesData sales, _) => sales.time,
                yValueMapper: (SalesData sales, _) => sales.value)
          ],
        ),
      ),
    );
  }

  List<SalesData> convertToSalesDataList(List<int> inputData) {
    List<SalesData> result = [];
    for (int i = 0; i < inputData.length; i++) {
      result.add(SalesData(i, inputData[i].toDouble()));
    }
    return result;
  }
}

class SalesData {
  SalesData(this.time, this.value);
  final int time;
  final double value;
}
