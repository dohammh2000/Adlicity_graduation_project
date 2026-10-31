import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/main_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';
import '../cubit/campaign_cubit.dart';
import 'profile_item_with_blur_buttons.dart';

// class CampgainOfferingSection extends StatelessWidget {
//   const CampgainOfferingSection({
//     super.key,
//     required this.status,
//      this.applicantsData,
//     required this.campaignData,
//   });

//   final String status;
//   final Map<String, dynamic>? applicantsData; // New parameter
//    final Map<String, dynamic> campaignData; // New parameter

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: status == 'offering',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//                 left: Constants.kPadding,
//                 top: Constants.kPadding,
//                 right: Constants.kPadding),
//             child: Text(
//               'publishers'.tr(),
//               style: TextStyle(
//                   color: AppColors.textColor,
//                   fontWeight: FontWeight.w700,
//                   fontFamily: AppStrings.fontFamily,
//                   fontSize: 15),
//             ),
//           ),
//           GridView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: applicantsData?.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.8, // Adjust the aspect ratio as needed
//               mainAxisSpacing: 10.0, // Add space between rows
//               crossAxisSpacing: 10.0, // Add space between columns
//             ),
//             itemBuilder: (context, index) {
//               return ProfileItemWithBlurButtons(
//                 index: index,
//                 campaignData: campaignData,
//                 applicantData: applicantsData?.values.toList()[index], // Pass applicant data
//                 firstButtonTitle: 'accept',
//                 firstButtonOnTap: () {},
//                 secondButtonTitle: 'reject',
//                 secondButtonOnTap: () {},
//               );
//             },
//             padding: EdgeInsets.all(Constants.kPadding),
//           ),
//         ],
//       ),
//     );
//   }
// }
class CampgainOfferingSection extends StatelessWidget {
  const CampgainOfferingSection(
      {super.key,
      required this.status,
      this.applicantsData,
      required this.campaignData,
      required this.cubit});

  final String status;
  final CampaignCubit cubit;
  final Map<String, dynamic>? applicantsData; // New parameter
  final Map<String, dynamic> campaignData; // New parameter

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: status == 'offering',
      child: BlocBuilder<CampaignCubit, CampaignState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is CampaignLoaded) {
            return Center(
              child: Container(
                width: context.width / 1.05, // Set the desired width
                child: ElevatedButton(
                  onPressed: () {
                    String campaignId = campaignData['campaignId'];
                    cubit.applyToCampaign(campaignId);
                    // Show a snackbar to inform the user that they applied successfully
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Applied to campaign successfully'),
                        duration:
                            Duration(seconds: 2), // Optional: Specify duration
                      ),
                    );
                  },
                  child: Text('Apply'),
                ),
              ),
            );
          } else if (state is CampaignsWithApplicantsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: Constants.kPadding,
                      top: Constants.kPadding,
                      right: Constants.kPadding),
                  child: Text(
                    'publishers'.tr(),
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: AppStrings.fontFamily,
                        fontSize: 15),
                  ),
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: applicantsData?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8, // Adjust the aspect ratio as needed
                    mainAxisSpacing: 10.0, // Add space between rows
                    crossAxisSpacing: 10.0, // Add space between columns
                  ),
                  itemBuilder: (context, index) {
                    return ProfileItemWithBlurButtons(
                      index: index,
                      campaignData: campaignData,
                      applicantData: applicantsData?.values
                          .toList()[index], // Pass applicant data
                      firstButtonTitle: 'accept',
                      firstButtonOnTap: () {},
                      secondButtonTitle: 'reject',
                      secondButtonOnTap: () {},
                    );
                  },
                  padding: EdgeInsets.all(Constants.kPadding),
                ),
              ],
            );
          } else {
            return Center(child: Text('No applicants found.'));
          }
        },
      ),
    );
  }
}

// class CampgainOfferingSection extends StatelessWidget {
//   const CampgainOfferingSection(
//       {super.key,
//       required this.status,
//       this.applicantsData,
//       required this.campaignData,
//       required this.cubit});

//   final String status;
//   final CampaignCubit cubit;
//   final Map<String, dynamic>? applicantsData; // New parameter
//   final Map<String, dynamic> campaignData; // New parameter

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: status == 'offering',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               left: Constants.kPadding,
//               top: Constants.kPadding,
//               right: Constants.kPadding,
//             ),
//             child: Text(
//               'publishers'.tr(),
//               style: TextStyle(
//                 color: AppColors.textColor,
//                 fontWeight: FontWeight.w700,
//                 fontFamily: AppStrings.fontFamily,
//                 fontSize: 15,
//               ),
//             ),
//           ),
//           if (applicantsData == null || applicantsData!.isEmpty)
//             Padding(
//               padding: EdgeInsets.all(Constants.kPadding),
//               child: Text(
//                 'No applicants',
//                 style: TextStyle(
//                   color: AppColors.textColor,
//                   fontSize: 14,
//                 ),
//               ),
//             )
//           else
//             GridView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: applicantsData?.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 0.8, // Adjust the aspect ratio as needed
//                 mainAxisSpacing: 10.0, // Add space between rows
//                 crossAxisSpacing: 10.0, // Add space between columns
//               ),
//               itemBuilder: (context, index) {
//                 return ProfileItemWithBlurButtons(
//                   index: index,
//                   campaignData: campaignData,
//                   applicantData: applicantsData?.values
//                       .toList()[index], // Pass applicant data
//                   firstButtonTitle: 'accept',
//                   firstButtonOnTap: () {},
//                   secondButtonTitle: 'reject',
//                   secondButtonOnTap: () {},
//                 );
//               },
//               padding: EdgeInsets.all(Constants.kPadding),
//             ),
//         ],
//       ),
//     );
//   }
// }