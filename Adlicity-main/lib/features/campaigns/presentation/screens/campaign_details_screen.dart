import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/widgets/report_dialog.dart';
import 'package:adlicity/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:adlicity/features/profile/presentation/widgets/monthly_clicks.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';

import '../../../../core/widgets/BlurButton.dart';
import '../../../../core/widgets/profile_item.dart';
import '../../../../core/widgets/rating_dialog.dart';
import '../../../../core/widgets/statistics_item.dart';
import '../widgets/campaign_details_header.dart';
import '../widgets/campgain_done_section.dart';
import '../widgets/campgain_offering_section.dart';
import '../widgets/profile_item_with_blur_buttons.dart';

class CampaignDetailsScreen extends StatelessWidget {
  final String status;
  final String date;
  final String title;
  final String description;
  final String category;
  final Set<String> adTypes;
  final String price;
  final String link;
  final Map<String, dynamic>? applicantsData; // New parameter
  final Map<String, dynamic> campaignData;
  final cubit;
  const CampaignDetailsScreen({
    Key? key,
    required this.status,
    required this.date,
    required this.title,
    required this.description,
    required this.category,
    required this.adTypes,
    required this.price,
    required this.link,
    this.applicantsData, // Initialize new
    required this.campaignData, // Initialize new parameter
    required this.cubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CampaignDetailsHeader(
              adTypes: adTypes,
              category: category,
              date: date,
              description: description,
              link: link,
              price: price,
              status: status,
              title: title,
            ),
            CampgainDoneSection(status: status, applicantsData: applicantsData, campaignData: campaignData, cubit: cubit),
            CampgainOfferingSection(
              status: status,
              applicantsData: applicantsData,
              campaignData: campaignData,
              cubit: cubit,
            ),
          ],
        ),
      ),
    );
  }
}
