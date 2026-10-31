
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/constants.dart';

class statisticsItem extends StatelessWidget {
  final double? height;
  final String title;
  final String subtitle;
  final String icon;

  const statisticsItem({
    super.key,
    this.height = 85,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: context.width * 0.43,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
        border: Border.all(color: AppColors.primary),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.third,
                borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  icon,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.tr(),
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
