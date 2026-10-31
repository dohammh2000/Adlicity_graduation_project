import 'package:adlicity/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/campaign_item.dart';
import '../screens/campaign_details_screen.dart';


class MyCampaignsSection extends StatelessWidget {
  const MyCampaignsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) { return BlocProvider(
      create: (context) => CampaignCubit()..loadCampaigns(),
      child: BlocBuilder<CampaignCubit, CampaignState>(
        builder: (context, state) {
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CampaignsWithApplicantsLoaded) {
            Map<String, Map<String, dynamic>> campaignsWithApplicants =
                state.campaignsWithApplicants;

            if (campaignsWithApplicants.isEmpty) {
              return Center(child: Text('No campaigns available'));
            }

            return ListView.separated(
              padding: EdgeInsets.only(top: 20),
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
                  onTap: () {
                    CampaignCubit cubit = context.read<CampaignCubit>();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider.value(
                          value: cubit,
                          child: CampaignDetailsScreen(
                            cubit: cubit,
                            // status: campaignData['status'] ?? 'offering',
                            status: 'done',
                            date: campaignData['end'] ?? 'No End Date',
                            title: campaignData['Title'] ?? 'No Title',
                            description: campaignData['Description'] ?? 'No Description',
                            category: campaignData['category'] ?? 'No Category',
                            adTypes: adTypesMap.keys.where((key) => adTypesMap[key]!).toSet(),
                            price: campaignData['budget'] ?? 0.0,
                            link: campaignData['link'] ?? 'No Link',
                            campaignData: campaignData,
                            applicantsData: applicantsData,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 20),
            );
          } else {
            return Center(child: Text('No campaigns available'));
          }
        },
      ),
    );
  }
}
