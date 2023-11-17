import 'package:flutter/material.dart';
import 'package:p_healthy/common/app_color.dart';
import 'package:p_healthy/model/enum/load_status.dart';
import 'package:p_healthy/ui/pages/heath_detail/widget/heart_beat_chart.dart';

import 'package:p_healthy/ui/pages/home/home_vm.dart';
import 'package:provider/provider.dart';

class HeathDetail extends StatefulWidget {
  const HeathDetail({super.key});

  @override
  State<HeathDetail> createState() => _HeathDetailState();
}

class _HeathDetailState extends State<HeathDetail> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback(
    //   (_) {
    //     context.read<HomeVM>().fetchHeatBeat();
    //     context.read<HomeVM>().fetchSpO2();
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: const Icon(
            Icons.short_text,
            size: 30,
            color: Colors.black,
          ),
          actions: <Widget>[
            const Icon(
              Icons.notifications_none,
              size: 30,
              color: LightColor.grey,
            ),
            const SizedBox(
              width: 8,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(13)),
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                ),
                child: Image.asset("assets/images/avt.jpg", fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return Selector<HomeVM, LoadStatus>(
    builder: (context, loadStatus, _) {
      switch (loadStatus) {
        case LoadStatus.initial:
          return _buildHome();
        case LoadStatus.loading:
          return Container();
        case LoadStatus.success:
          return _buildHome();
        case LoadStatus.failure:
          return Container();
      }
    },
    selector: (_, viewModel) => viewModel.fetchHeartBeatStatus,
  );
}

Widget _buildHome() {
  return Selector<HomeVM, List<int>>(
      selector: (_, viewModel) => viewModel.heartBeats,
      builder: (context, heartBeats, _) {
        return HeartBeatChart(heartBeat: heartBeats);
      });
}
