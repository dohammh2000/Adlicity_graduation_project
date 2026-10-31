import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:adlicity/features/campaigns/presentation/screens/campaign_details_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/campaign_item.dart';

// class OffersSection extends StatelessWidget {
//   const OffersSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CampaignCubit()..loadCampaigns(),
//       child: BlocBuilder<CampaignCubit, CampaignState>(
//         builder: (context, state) {
//           if (state is CampaignLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is CampaignLoaded) {
//             List<DocumentSnapshot> campaigns = state.campaigns;
//             return ListView.separated(
//               padding: EdgeInsets.only(top: 20),
//               itemCount: campaigns.length,
//               itemBuilder: (context, index) {
//                 var campaignData = campaigns[index].data() as Map<String, dynamic>?;
//                 if (campaignData == null) {
//                   return SizedBox.shrink();
//                 }
//                 return CampaignItem(
//                   title: campaignData['Title'] ?? 'No Title',
//                   price:  10.0,
//                   description: campaignData['Description'] ?? 'No Description',
//                   profileImages: Constants.testUsersImages,
//                   status:  'offering',
//                   category: campaignData['category'] ?? 'No Category',
//                   dateFrom: campaignData['start'] ?? 'No Start Date',
//                   dateTo: campaignData['end'] ?? 'No End Date',
//                   adTypes: {'story', 'post', 'inVideo', 'fullVideo', 'reel'},
//                   // profileNames: List.generate(
//                   //     (campaignData['profileImages'] as List<dynamic>?)?.length ?? 0,
//                   //     (index) => 'Sherif Mahmoud'),
//                    profileNames: List.generate(
//             Constants.testUsersImages.length, (index) => 'Sherif Mahmoud'),

// onTap: () {
//   CampaignCubit cubit = context.read<CampaignCubit>();
//   cubit.loadApplicants(campaigns[index].id);
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => BlocProvider.value(
//         value: cubit,
//         child: CampaignDetailsScreen(
//           status: 'offering',
//           date: campaignData['dateTo'] ?? 'No End Date',
//           title: campaignData['Title'] ?? 'No Title',
//           description: campaignData['Description'] ?? 'No Description',
//           category: campaignData['category'] ?? 'No Category',
//           adTypes: {'story', 'post', 'inVideo', 'fullVideo', 'reel'},
//           price: 1220.toDouble(),
//           link: campaignData['link'] ?? 'No Link',
//         ),
//       ),
//     ),
//   );
// },

//                 );
//               },
//               separatorBuilder: (context, index) => SizedBox(height: 20),
//             );
//           }
//            else {
//              // context.read<CampaignCubit>().resetToLoaded();
//             return Center(child: Text('Error loading campaigns'));
//           }
//         },
//       ),
//     );
//   }
// }

// class OffersSection extends StatelessWidget {
//   const OffersSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CampaignCubit()..loadCampaignsWithApplicants(),
//       child: BlocBuilder<CampaignCubit, CampaignState>(
//         builder: (context, state) {
//           if (state is CampaignLoading) {
//             return Center(child: CircularProgressIndicator());
//           } else if (state is CampaignsWithApplicantsLoaded) {
//             Map<String, Map<String, dynamic>> campaignsWithApplicants = state.campaignsWithApplicants;
//             return ListView.separated(
//               padding: EdgeInsets.only(top: 20),
//               itemCount: campaignsWithApplicants.length,
//               itemBuilder: (context, index) {
//                 String campaignId = campaignsWithApplicants.keys.elementAt(index);
//                 Map<String, dynamic> campaignData = campaignsWithApplicants[campaignId]!['campaignData'] as Map<String, dynamic>;
//                 Map<String, dynamic> applicantsData = campaignsWithApplicants[campaignId]!['applicantsData'] as Map<String, dynamic>;

//                 return CampaignItem(
//                   title: campaignData['Title'] ?? 'No Title',
//                   price: 10.0,
//                   description: campaignData['Description'] ?? 'No Description',
//                   profileImages: Constants.testUsersImages,
//                   status: 'offering',
//                   category: campaignData['category'] ?? 'No Category',
//                   dateFrom: campaignData['start'] ?? 'No Start Date',
//                   dateTo: campaignData['end'] ?? 'No End Date',
//                   adTypes: {'story', 'post', 'inVideo', 'fullVideo', 'reel'},
//                   profileNames: List.generate(
//                     Constants.testUsersImages.length, (index) => 'Sherif Mahmoud'),
//                   onTap: () {
//                     CampaignCubit cubit = context.read<CampaignCubit>();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BlocProvider.value(
//                           value: cubit,
//                           child: CampaignDetailsScreen(
//                             status: 'offering',
//                             date: campaignData['dateTo'] ?? 'No End Date',
//                             title: campaignData['Title'] ?? 'No Title',
//                             description: campaignData['Description'] ?? 'No Description',
//                             category: campaignData['category'] ?? 'No Category',
//                             adTypes: {'story', 'post', 'inVideo', 'fullVideo', 'reel'},
//                             price: 1220.toDouble(),
//                             link: campaignData['link'] ?? 'No Link',
//                            campaignData: campaignData, // Pass the applicants data to the details screen
//                             applicantsData: applicantsData, // Pass the applicants data to the details screen
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               separatorBuilder: (context, index) => SizedBox(height: 20),
//             );
//           } else {
//             return Center(child: Text('Error loading campaigns'));
//           }
//         },
//       ),
//     );
//   }
// }
class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignCubit()..loadCampaignsWithApplicants(),
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
                  status: campaignData['status'] ?? 'offering',
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
                            status: campaignData['status'] ?? 'offering',
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
            return Center(child: Text('No offers available'));
          }
        },
      ),
    );
  }
}