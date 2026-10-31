import 'dart:io';

import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/profile_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../cubit/add_campgain_cubit.dart';

class GoalStep extends StatefulWidget {
  const GoalStep({
    Key? key,
    required this.cubit,
    required this.imageFile,
    required this.onImageSelected,
  }) : super(key: key);

  final AddCampgainCubit cubit;
  final File? imageFile; // Receive imageFile as a parameter
  final Function(File? imageFile) onImageSelected;

  @override
  _GoalStepState createState() => _GoalStepState();
}

class _GoalStepState extends State<GoalStep> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.cubit.activeStep == 2,
      child: Form(
        key: widget.cubit.goalFormKey,
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
              controller: widget.cubit.budget,
              hintText: 'budget',
              maxLines: 1,
              keyboardType: TextInputType.phone,
              prefixIcon: Icon(
                Icons.attach_money,
                color: AppColors.primary,
              ),
              validator: (value) => widget.cubit.validateGoalForm(),
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
                      widget.cubit.changeAdGoal(value!);
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
                  final platform = Constants.platforms[index]; // Get the platform
                  final isChecked = widget.cubit.chosenPlatform.containsKey(platform)
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
                      widget.cubit.togglePlatform(
                          index: index,
                          value: value ?? false); // Pass the value or default to false
                      print(widget.cubit.chosenPlatform[Constants.platforms[index]]);
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
                      widget.cubit.changePublishersChoiceType(value!);
                    },
                  );
                },
              ),
            ),
            Visibility(
              visible: Constants.publishersChoiceTypes[1].toLowerCase() ==
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
                        borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
                      ),
                      child: ListView.builder(
                        itemCount: widget.cubit.filteredList.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            String userName = widget.cubit.filteredList[index]['FullName'];
                            final user = widget.cubit.filteredList[index];
                            widget.cubit.selectUserProfile(user);
                            setState(() {
                              widget.cubit.searchController.text = userName;
                            });
                          },
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(ImagesAssets.preson1),
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
                      padding: EdgeInsetsDirectional.only(start: Constants.kPadding),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final userData = widget.cubit.userDataList[index];
                        final isVisible = widget.cubit.selectedUserProfiles.contains(userData);
                        return Visibility(
                          visible: isVisible,
                          child: ProfileItem(
                            facebookFollowers: userData['facebookFollowers'] ?? 'f',
                            instagramFollowers: userData['instagramFollowers'] ?? 'i',
                            tiktokFollowers: userData['tiktokFollowers'] ?? 't',
                            twitterFollowers: userData['twitterFollowers'] ?? 'tw',
                            youTubeFollowers: userData['youTubeFollowers'] ?? 'y',
                            profileImage: Constants.usersImagesTest[index],
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
                        widget.cubit.updateActiveStep(widget.cubit.activeStep - 1);
                      });
                    },
                    title: 'back'),
                MainButton(
                    width: context.width / 2.4,
                    onPressed: () {
                      if (widget.cubit.goalFormKey.currentState!.validate()) {
                        widget.cubit.updateActiveStep(widget.cubit.activeStep + 1);
                        widget.cubit.addCampaign(widget.imageFile);
                      }
                    },
                    title: 'confirm'),
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ).animate().fade(duration: Duration(milliseconds: 500)),
      ),
    );
  }
}