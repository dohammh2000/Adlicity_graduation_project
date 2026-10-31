import 'package:adlicity/core/widgets/campaign_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../cubit/profile_cubit.dart';


class ProfilePortfolioSection extends StatefulWidget {
  final ScrollController scrollController;

  const ProfilePortfolioSection({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  @override
  _ProfilePortfolioSectionState createState() => _ProfilePortfolioSectionState();
}

class _ProfilePortfolioSectionState extends State<ProfilePortfolioSection> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadlastCampaigns();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
       if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CampaignsWithApplicantsLoaded) {
            Map<String, Map<String, dynamic>> campaignsWithApplicants =
                state.campaignsWithApplicants;

            if (campaignsWithApplicants.isEmpty) {
              return Center(child: Text('No campaigns available'));
            }
          return SingleChildScrollView(
            controller: widget.scrollController,
            child: Padding(
              padding: EdgeInsets.all(Constants.kPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'last_campaigns'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: campaignsWithApplicants.length,
                    itemBuilder: (context, index) {
                       String campaignId =
                    campaignsWithApplicants.keys.elementAt(index);
                Map<String, dynamic> campaignData =
                    campaignsWithApplicants[campaignId]!['campaignData']
                        as Map<String, dynamic>;
                Map<String, dynamic> applicantsData =
                    campaignsWithApplicants[campaignId]!['applicantsData']
                        as Map<String, dynamic>;
              Map<String, bool> adTypesMap = Map<String, bool>.from(
                    campaignData['ad_type'] ?? {});

                return CampaignItem(
                  title: campaignData['Title'] ?? 'No Title',
                  price: campaignData['budget']?.toString() ?? 'No Price',
                  description: campaignData['Description'] ?? 'No Description',
                  profileImages: applicantsData.values
                      .map((applicant) => applicant['profileImage'].toString())
                      .toList(),
                  status: 'done',
                  category: campaignData['category'] ?? 'No Category',
                  dateFrom: campaignData['start'] ?? 'No Start Date',
                  dateTo: campaignData['end'] ?? 'No End Date',
                  adTypes: adTypesMap.keys.where((key) => adTypesMap[key]!).toSet(),
                  profileNames: applicantsData.values
                      .map((applicant) => applicant['FullName'].toString())
                      .toList(),
                        isPadding: false,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                ],
              ),
            ),
          );
        } else if (state is CampaignError) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text('Unknown state'));
        }
      },
    );
  }
}