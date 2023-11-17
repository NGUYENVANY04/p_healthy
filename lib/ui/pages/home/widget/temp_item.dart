import 'package:flutter/material.dart';
import 'package:p_healthy/common/app_size.dart';
import 'package:p_healthy/common/app_text_style.dart';

class TempItemWidget extends StatelessWidget {
  const TempItemWidget({
    super.key,
    required this.color,
    required this.title,
    required this.subTitle,
    required this.lightColor,
    required this.icon,
  });
  final Color color;
  final String title;
  final String subTitle;
  final Color lightColor;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSize.fullHeight(context) * .1,
      width: AppSize.fullWidth(context) * 0.4,
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
      child: Row(
        children: [
          const SizedBox(
            width: 12,
          ),
          icon,
          const SizedBox(
            width: 12,
          ),
          RichText(
            text: TextSpan(
              text: title,
              style: AppTextStyle.whiteS40Bold,
              children: <TextSpan>[
                TextSpan(text: '℃', style: AppTextStyle.whiteS16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
