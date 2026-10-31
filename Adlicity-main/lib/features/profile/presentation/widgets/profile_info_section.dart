import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

class ProfileInfoSection extends StatelessWidget {
  // const ProfileInfoSection({
  //   super.key,
  //   required ScrollController scrollController,
  // }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final Map<String, dynamic> profileData;
  ProfileInfoSection({
    required ScrollController scrollController,
    required this.profileData,
  }) : _scrollController = scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: EdgeInsets.all(Constants.kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'about'.tr(),
              style: TextStyle(
                color: AppColors.primary,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              profileData['profileInfo'],
              style: TextStyle(
                color: AppColors.textColor,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
