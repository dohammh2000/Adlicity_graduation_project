// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/BlurButton.dart';
import '../../../../core/widgets/profile_item.dart';
import '../../../../core/widgets/rating_dialog.dart';
import '../../../../core/widgets/report_dialog.dart';
import '../../../../core/widgets/statistics_item.dart';
import '../../../profile/presentation/widgets/monthly_clicks.dart';
import '../cubit/campaign_cubit.dart';
import 'profile_item_with_blur_buttons.dart';

class CampgainDoneSection extends StatelessWidget {
  const CampgainDoneSection({
    super.key,
    required this.status,
    required this.cubit,
    this.applicantsData,
    required this.campaignData,
    // required this.cubit,
  });

  final String status;
  // final CampaignCubit cubit;

  final CampaignCubit cubit;
  final Map<String, dynamic>? applicantsData; // New parameter
  final Map<String, dynamic> campaignData; // New parameter

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status == 'done',
      child: BlocBuilder<CampaignCubit, CampaignState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is CampaignsWithApplicantsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(Constants.kPadding),
                  child: Text(
                    'publishers'.tr(),
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppStrings.fontFamily,
                        fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                    padding: EdgeInsetsDirectional.symmetric(
                        horizontal: Constants.kPadding),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ProfileItemWithBlurButtons(
                      applicantData: applicantsData?.values
                          .toList()[index],
                      campaignData: campaignData,
                      // cubit: cubit,
                      index: index,
                      firstButtonTitle: 'rate',
                      firstButtonOnTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => RateDialog(
                            profileImage: Constants.usersImagesTest[index],
                            profileName: 'Sherif Mahmoud',
                            userId: '',
                          ),
                        );
                      },
                      secondButtonTitle: 'report',
                      secondButtonOnTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ReportDialog(
                            profileImage: Constants.usersImagesTest[index],
                            profileName: 'Sherif Mahmoud',
                          ),
                        );
                      },
                    ),
                    itemCount: applicantsData!.length,
                    separatorBuilder: (context, index) => SizedBox(width: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Constants.kPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'statistics'.tr(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w700,
                            fontFamily: AppStrings.fontFamily,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
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
                      Gap(40),
                      Text(
                        'monthly_clicks'.tr(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.w500,
                            fontFamily: AppStrings.fontFamily,
                            fontSize: 12),
                      ),
                      Gap(10),
                      MonthlyClicks(),
                      Gap(20),
                    ],
                  ),
                ),
              ],
            );
          } else {
             return Center(child: Text('Error.'));
          }
        },
      ),
    );
  }
}
