import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:p_healthy/common/app_color.dart';
import 'package:p_healthy/common/app_image.dart';
import 'package:p_healthy/common/app_text_style.dart';
import 'package:p_healthy/common/app_vector.dart';
import 'package:p_healthy/model/enum/load_status.dart';
import 'package:p_healthy/ui/pages/heath_detail/heath_detail.dart';

import 'package:p_healthy/ui/pages/home/home_vm.dart';
import 'package:p_healthy/ui/pages/home/widget/heath_item.dart';
import 'package:p_healthy/ui/pages/home/widget/temp_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeVM>().fetchHeatBeat();
      context.read<HomeVM>().fetchSpO2();
      context.read<HomeVM>().fetchBodyTemp();
      context.read<HomeVM>().fetchOutsideTemp();
    });
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
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hi!",
          style: AppTextStyle.blackS20,
        ),
        Text(
          "P - CARE",
          style: AppTextStyle.blackS32Bold,
        ),
        const SizedBox(
          height: 28,
        ),
        Text(
          "Heath",
          style: AppTextStyle.blackS24Bold,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<HomeVM, int>(
                selector: (_, viewModel) => viewModel.heartBeat,
                builder: (context, heartBeat, _) {
                  return HeathItemWidget(
                    ontap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HeathDetail()),
                      );
                    },
                    color: LightColor.orange,
                    lightColor: LightColor.lightOrange,
                    title: "$heartBeat",
                    subTitle: "Heart Beat",
                    icon: const Icon(
                      Icons.favorite_rounded,
                      size: 56,
                      color: Colors.white,
                    ),
                  );
                }),
            Selector<HomeVM, int>(
              selector: (_, viewModel) => viewModel.spO2,
              builder: (context, spO2, _) {
                return HeathItemWidget(
                  ontap: () {},
                  color: LightColor.skyBlue,
                  lightColor: LightColor.lightBlue,
                  title: "$spO2",
                  subTitle: "SPO2",
                  icon: SvgPicture.asset(
                    AppVector.icSpO2,
                    height: 52,
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Temperature",
          style: AppTextStyle.blackS24Bold,
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Selector<HomeVM, int>(
                selector: (_, viewModel) => viewModel.bodyTemp,
                builder: (context, bodyTemp, _) {
                  return TempItemWidget(
                    color: LightColor.green,
                    title: "$bodyTemp",
                    subTitle: "Body temperature",
                    lightColor: LightColor.lightGreen,
                    icon: Image.asset(
                      AppImage.icBodyTemp,
                      height: 36,
                    ),
                  );
                }),
            Selector<HomeVM, int>(
                selector: (_, viewModel) => viewModel.outsideTemp,
                builder: (context, outsideTemp, _) {
                  return TempItemWidget(
                    color: LightColor.green,
                    title: "$outsideTemp",
                    subTitle: "Outside temperature",
                    lightColor: LightColor.lightGreen,
                    icon: Image.asset(
                      AppImage.icOutSideTemp,
                      height: 36,
                    ),
                  );
                })
          ],
        ),
      ],
    ),
  );
}
