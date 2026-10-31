import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/statistics_item.dart';
import 'audience_age.dart';
import 'gender_pie.dart';
import 'monthly_clicks.dart';
import 'top_countries.dart';

class ProfileStatisticsSection extends StatelessWidget {
  const ProfileStatisticsSection({
    super.key,
    required ScrollController scrollController,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: EdgeInsets.all(Constants.kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                statisticsItem(
                  icon: IconsAssets.clickOutline,
                  title: 'total_clicks',
                  subtitle: '1.3K',
                ),
                statisticsItem(
                  icon: IconsAssets.avgOutline,
                  title: 'avg_click_cost',
                  subtitle: '0.8\$',
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'gender'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GenderPie(),
            SizedBox(
              height: 50,
            ),
            Text(
              'monthly_clicks'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MonthlyClicks(),
            SizedBox(
              height: 50,
            ),
            Text(
              'audience_age'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            AudienceAge(),
            SizedBox(
              height: 40,
            ),
            Text(
              'top_countries'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            TopCountries(),
          ],
        ),
      ),
    );
  }
}
