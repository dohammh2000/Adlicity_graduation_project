import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/BlurButton.dart';
import '../../../../core/widgets/profile_item.dart';
import '../../../../core/widgets/rating_dialog.dart';
import '../../../../core/widgets/report_dialog.dart';
import '../cubit/campaign_cubit.dart';


class ProfileItemWithBlurButtons extends StatelessWidget {
  final int index;
  final Map<String, dynamic> applicantData;
  final Map<String, dynamic> campaignData;
  final String firstButtonTitle;
  final Function() firstButtonOnTap;
  final String secondButtonTitle;
  final Function() secondButtonOnTap;

  ProfileItemWithBlurButtons({
    Key? key,
    required this.index,
    required this.campaignData,
    required this.applicantData,
    required this.firstButtonTitle,
    required this.firstButtonOnTap,
    required this.secondButtonTitle,
    required this.secondButtonOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle on tap
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ProfileItem(
            facebookFollowers: applicantData['facebookFollowers'] ?? 'N/A',
            instagramFollowers: applicantData['instagramFollowers'] ?? 'N/A',
            tiktokFollowers: applicantData['tiktokFollowers'] ?? 'N/A',
            twitterFollowers: applicantData['twitterFollowers'] ?? 'N/A',
            youTubeFollowers: applicantData['youTubeFollowers'] ?? 'N/A',
            profileImage: applicantData['profileImage'] ?? 'N/A',
            profileInfo: applicantData['profileInfo'] ?? 'N/A',
            profileName: applicantData['profileName'] ?? 'N/A',
            profileRate: applicantData['profileRate']?.toDouble() ?? 0.0,
          ),
          Visibility(
            visible: true, // Set this based on your logic
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBlur(
                  onTap: () {
                    // Call the accept method when the accept button is pressed
                    context.read<CampaignCubit>().acceptApplicant(
                      // Assuming 'id' is the key for the applicant ID
                     campaignData['campaignId'],
                      applicantData['id'], // Set the new status to 'accept'
                    );
                    // Call the provided onTap function
                    firstButtonOnTap();
                    // Show a snackbar to inform the user that they applied successfully
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'ACCEPTTED'),
                                              duration: Duration(
                                                  seconds:
                                                      2), 
                                                      ),
                                          );// Optional: Specify duration
                  },
                  title: firstButtonTitle,
                ),
                SizedBox(height: 10),
                ButtonBlur(
                  onTap: () {
                    // Call the remove applicant method when the reject button is pressed
                    context.read<CampaignCubit>().rejectApplicant(
                     
                      campaignData['campaignId'],
                       applicantData['id']);
                    // Call the provided onTap function
                    secondButtonOnTap();
                    // Show a snackbar to inform the user that they applied successfully
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'REJECTED'),
                                              duration: Duration(
                                                  seconds:
                                                      2), 
                                                      ),
                                          );// Optional: Specify duration
                  },
                  title: secondButtonTitle,
                ),
              ],
            ).animate().fade(duration: Duration(milliseconds: 500)),
          ),
        ],
      ),
    );
  }
}
