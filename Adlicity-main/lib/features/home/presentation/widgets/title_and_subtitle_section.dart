// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

class TitleAndSubtitleSection extends StatelessWidget {
  final String title;
  final String subtitle;
   final String title2;
  const TitleAndSubtitleSection({
    Key? key,
    required this.title,
    required this.subtitle,
     this.title2 = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title.toString().tr(),
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: AppStrings.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
              Text(
                ' $title2',
                style: TextStyle(
                  color: AppColors.primary,
                  fontFamily: AppStrings.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Text(
            subtitle.tr(),
            style: TextStyle(
              color: AppColors.textColor,
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
