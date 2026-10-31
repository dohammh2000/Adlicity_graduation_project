import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/profile_item.dart';
import 'package:adlicity/features/add_proposal/presentation/cubit/add_proposal_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';

// class GoalStepProposal extends StatelessWidget {
//   const GoalStepProposal({
//     super.key,
//     required this.cubit,
//   });

//   final AddProposalCubit cubit;

//   @override
//   Widget build(BuildContext context) {
//     return Visibility(
//       visible: cubit.activeStep == 2,
//       child: Column(
//         children: [
//           Image.asset(
//             ImagesAssets.goalAva,
//             width: context.width * 0.7,
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           InputField(
//             controller: cubit.price,
//             hintText: 'price',
//             maxLines: 1,
//             prefixIcon: Icon(
//               Icons.attach_money,
//               color: AppColors.primary,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),

//           Align(
//             alignment: AlignmentDirectional.centerStart,
//             child: Text(
//               'publish_on'.tr(),
//               style: TextStyle(
//                 color: AppColors.textColor,
//                 fontSize: 12,
//                 fontFamily: AppStrings.fontFamily,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 160,
//             child: GridView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.all(0),
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: Constants.platforms.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 3.5,
//                 crossAxisSpacing: 50,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 final platform = Constants.platforms[index]; // Get the adType
//                 final isChecked = cubit.chosenPlatform.containsKey(platform)
//                     ? cubit.chosenPlatform[platform]
//                     : false; // Check if the key exists
//                 return CheckboxListTile.adaptive(
//                   contentPadding: EdgeInsets.all(0),
//                   value: isChecked,
//                   controlAffinity: ListTileControlAffinity.leading,
//                   title: Text(
//                     platform.tr(),
//                     style: TextStyle(
//                         color: AppColors.textColor,
//                         fontFamily: AppStrings.fontFamily,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w700),
//                   ),
//                   activeColor: AppColors.primary,
//                   side: BorderSide(color: AppColors.primary),
//                   onChanged: (bool? value) {
//                     cubit.togglePlatform(
//                         index: index,
//                         value: value ??
//                             false); // Pass the value or default to false
//                     print(cubit.chosenPlatform[Constants.platforms[index]]);
//                   },
//                 );
//               },
//             ),
//           ),
//           Align(
//             alignment: AlignmentDirectional.centerStart,
//             child: Text(
//               'choose_publisher'.tr(),
//               style: TextStyle(
//                 color: AppColors.textColor,
//                 fontSize: 12,
//                 fontFamily: AppStrings.fontFamily,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 120,
//             child: GridView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.all(0),
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: Constants.publishersChoiceTypes.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 childAspectRatio: 3.5,
//                 crossAxisSpacing: 10,
//               ),
//               itemBuilder: (BuildContext context, int index) {
//                 return RadioListTile.adaptive(
//                   controlAffinity: ListTileControlAffinity.leading,
//                   activeColor: AppColors.primary,
//                   title: Text(
//                     Constants.publishersChoiceTypes[index].tr(),
//                     style: TextStyle(
//                       color: AppColors.textColor,
//                       fontFamily: AppStrings.fontFamily,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   value: Constants.publishersChoiceTypes[index],
//                   groupValue: cubit.publishersChoiceType,
//                   onChanged: (value) {
//                     cubit.changePublishersChoiceType(value!);
//                   },
//                 );
//               },
//             ),
//           ),
//           Visibility(
//             visible: Constants.publishersChoiceTypes[2].toLowerCase() ==
//                 cubit.publishersChoiceType.toLowerCase(),
//             child: Column(
//               children: [
//                 InputField(
//                   controller: cubit.searchController,
//                   hintText: 'search',
//                   maxLines: 1,
//                   prefixIcon: Icon(
//                     Icons.search,
//                     color: AppColors.primary,
//                   ),
//                   onChanged: (value) {
//                     cubit.updateSearch(value);
//                   },
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Visibility(
//                   visible: cubit.searchController.text.length > 0,
//                   child: Container(
//                     height: 250,
//                     width: context.width,
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: AppColors.primary,
//                       ),
//                       borderRadius:
//                           BorderRadius.circular(Constants.kRoundedCorner),
//                     ),
//                     child: ListView.separated(
//                         itemBuilder: (context, index) => ListTile(
//                               leading: CircleAvatar(
//                                 radius: 20,
//                                 backgroundImage:
//                                     AssetImage(ImagesAssets.logo),
//                               ),
//                               title: Text(
//                                 'Adlicity',
//                               ),
//                               titleTextStyle: TextStyle(
//                                   color: AppColors.primary,
//                                   fontFamily: AppStrings.fontFamily,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 12),
//                               subtitle: Text('Adverter form Egypt'),
//                               subtitleTextStyle: TextStyle(
//                                 color: AppColors.textColor,
//                                 fontFamily: AppStrings.fontFamily,
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 10,
//                               ),
//                             ),
//                         separatorBuilder: (context, index) =>
//                             Divider(color: AppColors.primary),
//                         itemCount: 10),
//                   ).animate().fadeIn(duration: Duration(milliseconds: 500)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Align(
//                   alignment: AlignmentDirectional.centerStart,
//                   child: Text(
//                     'chosen_publishers'.tr(),
//                     style: TextStyle(
//                       color: AppColors.textColor,
//                       fontSize: 12,
//                       fontFamily: AppStrings.fontFamily,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: 220,
//                   child: ListView.separated(
//                     padding:
//                         EdgeInsetsDirectional.only(start: Constants.kPadding),
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, index) => ProfileItem(
//                       facebookFollowers: '1.4M',
//                       instagramFollowers: '192.3K',
//                       tiktokFollowers: '2.3M',
//                       twitterFollowers: '132.9K',
//                       youTubeFollowers: '23.5K',
//                       profileImage: ImagesAssets.logo,
//                       profileInfo: 'Advertier From Egypt',
//                       profileName: 'Adlicity',
//                       profileRate: 4.8,
//                     ),
//                     itemCount: Constants.usersImagesTest.length,
//                     separatorBuilder: (context, index) => SizedBox(width: 15),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 40,
//                 )
//               ],
//             ).animate().fadeIn(duration: Duration(milliseconds: 1000)),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               MainButton(
//                   width: context.width / 2.4,
//                   backgroundColors: [AppColors.third, AppColors.third],
//                   titleColor: AppColors.primary,
//                   onPressed: () {
//                     cubit.updateActiveStep(cubit.activeStep - 1);
//                   },
//                   title: 'back'),
//               MainButton(
//                   width: context.width / 2.4,
//                   onPressed: () {
//                     cubit.updateActiveStep(cubit.activeStep + 1);
//                   },
//                   title: 'confirm'),
//             ],
//           ),
//           SizedBox(
//             height: 40,
//           ),
//         ],
//       ).animate().fade(duration: Duration(milliseconds: 500)),
//     );
//   }
// }
class GoalStepProposal extends StatefulWidget {
  const GoalStepProposal({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AddProposalCubit cubit;

  @override
  _GoalStepState createState() => _GoalStepState();
}

class _GoalStepState extends State<GoalStepProposal> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.cubit.activeStep == 2,
      child: Column(
        children: [
          Image.asset(
            ImagesAssets.goalAva,
            width: context.width * 0.7,
          ),
          SizedBox(
            height: 20,
          ),
          InputField(
            controller: widget.cubit.price,
            hintText: 'price',
            maxLines: 1,
            prefixIcon: Icon(
              Icons.attach_money,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'goal'.tr(),
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 12,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: Constants.adGoals.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile.adaptive(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.primary,
                  title: Text(
                    Constants.adGoals[index].tr(),
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  value: Constants.adGoals[index],
                  groupValue: widget.cubit.adGoal,
                  onChanged: (value) {
                    // setState(() {
                    widget.cubit.changeAdGoal(value!);
                    // });
                  },
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'publish_on'.tr(),
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 12,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 160,
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: Constants.platforms.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                crossAxisSpacing: 50,
              ),
              itemBuilder: (BuildContext context, int index) {
                final platform = Constants.platforms[index]; // Get the adType
                final isChecked =
                    widget.cubit.chosenPlatform.containsKey(platform)
                        ? widget.cubit.chosenPlatform[platform]
                        : false; // Check if the key exists
                return CheckboxListTile.adaptive(
                  contentPadding: EdgeInsets.all(0),
                  value: isChecked,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    platform.tr(),
                    style: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: AppStrings.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  activeColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary),
                  onChanged: (bool? value) {
                    // setState(() {
                    widget.cubit.togglePlatform(
                        index: index,
                        value: value ??
                            false); // Pass the value or default to false
                    //  });
                    print(widget
                        .cubit.chosenPlatform[Constants.platforms[index]]);
                  },
                );
              },
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'choose_publisher'.tr(),
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 12,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 120,
            child: GridView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemCount: Constants.publishersChoiceTypes.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3.5,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return RadioListTile.adaptive(
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: AppColors.primary,
                  title: Text(
                    Constants.publishersChoiceTypes[index].tr(),
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  value: Constants.publishersChoiceTypes[index],
                  groupValue: widget.cubit.publishersChoiceType,
                  onChanged: (value) {
                    // setState(() {
                    widget.cubit.changePublishersChoiceType(value!);
                    // });
                  },
                );
              },
            ),
          ),
          // Inside the Visibility widget where you display ProfileItem
          Visibility(
            visible: Constants.publishersChoiceTypes[2].toLowerCase() ==
                widget.cubit.publishersChoiceType.toLowerCase(),
            child: Column(
              children: [
                InputField(
                  controller: widget.cubit.searchController,
                  hintText: 'search',
                  maxLines: 1,
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.primary,
                  ),
                  onChanged: (value) {
                    setState(() {
                      widget.cubit.name = value;
                      widget.cubit.updateSearch(value);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                  visible: widget.cubit.searchController.text.length > 0,
                  child: Container(
                    height: 250,
                    width: context.width,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                      ),
                      borderRadius:
                          BorderRadius.circular(Constants.kRoundedCorner),
                    ),
                    child: ListView.builder(
                      itemCount: widget.cubit.filteredList.length,
                      itemBuilder: (context, index) => ListTile(
                        onTap: () {
                          String userName =
                              widget.cubit.filteredList[index]['FullName'];
                          final user = widget.cubit.filteredList[index];
                          widget.cubit.selectUserProfile(user);
                          //  String id = widget.cubit.filteredList[index]['id'];
                          setState(() {
                            widget.cubit.searchController.text = userName;
                            //  widget.cubit.onUserNameClicked(id);
                          });
                          // cubit.toggleProfileItemVisibility();
                        },
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              widget.cubit.filteredList[index]['profileImage']),
                        ),
                        title: Text(
                          widget.cubit.filteredList[index]['FullName'],
                          style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: AppStrings.fontFamily,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                        // subtitle: Text('Publisher from Egypt'),
                        // subtitleTextStyle: TextStyle(
                        //   color: AppColors.textColor,
                        //   fontFamily: AppStrings.fontFamily,
                        //   fontWeight: FontWeight.w600,
                        //   fontSize: 10,
                        // ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    'chosen_publishers'.tr(),
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontSize: 12,
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                    padding:
                        EdgeInsetsDirectional.only(start: Constants.kPadding),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      // Access user data from the filteredUserList
                      final userData = widget.cubit.userDataList[index];
                      // bool isVisible = userData['isVisible'] ??
                      //  false; // Get the visibility status

                      final isVisible =
                          widget.cubit.selectedUserProfiles.contains(userData);
                      return Visibility(
                        visible: isVisible,
                        // Wrap the ProfileItem with Visibility widget
                        // visible:
                        //     isVisible, // Set the visibility based on the status
                        child: ProfileItem(
                          facebookFollowers:
                              userData['facebookFollowers'] ?? 'f',
                          instagramFollowers:
                              userData['instagramFollowers'] ?? 'i',
                          tiktokFollowers: userData['tiktokFollowers'] ?? 't',
                          twitterFollowers:
                              userData['twitterFollowers'] ?? 'tw',
                          youTubeFollowers: userData['youTubeFollowers'] ?? 'y',
                          profileImage: userData['profileImage'] ??
                              'https://firebasestorage.googleapis.com/v0/b/adlicity-sherif.appspot.com/o/images%2F1715725701462?alt=media&token=d4741fae-4c1d-4ce8-9787-4a29fe8e8f0f',
                          //userData['image'] ?? 'https://firebasestorage.googleapis.com/v0/b/adlicity-sherif.appspot.com/o/images%2F1715725701462?alt=media&token=d4741fae-4c1d-4ce8-9787-4a29fe8e8f0f',
                          profileInfo: userData['profileInfo'] ?? 'info',
                          profileName: userData['profileName'] ?? 'name',
                          profileRate: userData['profileRate'] ?? 0.0,
                        ),
                      );
                    },
                    itemCount: widget.cubit.userDataList.length,
                    separatorBuilder: (context, index) => SizedBox(width: 15),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ).animate().fadeIn(duration: Duration(milliseconds: 1000)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainButton(
                  width: context.width / 2.4,
                  backgroundColors: [AppColors.third, AppColors.third],
                  titleColor: AppColors.primary,
                  onPressed: () {
                    setState(() {
                      widget.cubit
                          .updateActiveStep(widget.cubit.activeStep - 1);
                    });
                  },
                  title: 'back'),
              MainButton(
                  width: context.width / 2.4,
                  onPressed: () {
                    //  setState(() {
                    widget.cubit.updateActiveStep(widget.cubit.activeStep + 1);
                    //    if (widget.cubit.resourcesFormKey.currentState!.validate()) {
                    //   widget.cubit.updateActiveStep(widget.cubit.activeStep + 1);
                    // }

                    //});
                    widget.cubit.addProposal();
                  },
                  title: 'confirm'),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ).animate().fade(duration: Duration(milliseconds: 500)),
    );
  }
}
