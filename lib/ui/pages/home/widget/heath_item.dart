import 'package:flutter/material.dart';
import 'package:p_healthy/common/app_size.dart';
import 'package:p_healthy/common/app_text_style.dart';

class HeathItemWidget extends StatelessWidget {
  const HeathItemWidget(
      {super.key,
      required this.color,
      required this.title,
      required this.subTitle,
      required this.lightColor,
      required this.icon, required this.ontap});
  final Color color;
  final String title;
  final String subTitle;
  final Color lightColor;
  final Widget icon;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: AppSize.fullHeight(context) * .25,
        width: AppSize.fullWidth(context) * .4,
        // margin: const EdgeInsets.only(),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: -20,
                left: -20,
                child: CircleAvatar(
                  backgroundColor: lightColor,
                  radius: 60,
                  child: icon,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: AppTextStyle.whiteS64Bold),
                    Text(
                      subTitle,
                      style: AppTextStyle.whiteS18,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
