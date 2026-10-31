import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/appbar_circle_button.dart';
import 'package:adlicity/core/widgets/report_dialog.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info_popup/info_popup.dart';

import '../../config/themes/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';
import '../utils/constants.dart';
import 'rating_dialog.dart';

class MyProfileInfoItem extends StatelessWidget {
  final String profileImage;
  final String profileName;
  final String profileInfo;
  final double profileRate;
  final String userId;
  const MyProfileInfoItem({
    super.key,
    required this.profileImage,
    required this.profileName,
    required this.profileInfo,
    required this.profileRate,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    late InfoPopupController infoPopupController;

    return Container(
      margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
      height: context.height * 0.065,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          children: [
            Image(
              image: BlurhashTheImage(
                  NetworkImage(
                      profileImage), // you can use any image provider of your choice.
                  decodingHeight: 1920,
                  decodingWidth: 1080),
              width: context.width,
              height: context.height * 0.065,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Padding(
                //   padding: const EdgeInsetsDirectional.only(start: 3),
                //   child: IconButton(
                //     onPressed: () {},
                //     icon: Image.asset(
                //       IconsAssets.dotsWhite,
                //       width: 18,
                //     ),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 20),
                  child: InfoPopupWidget(
                    customContent: () => Container(
                      width: context.width * 0.5,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Constants.kRoundedCorner),
                          border:
                              Border.all(color: AppColors.primary, width: 1)),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              infoPopupController.dismissInfoPopup();
                            },
                            child: Row(
                              children: [
                                AppbarCircleButton(
                                    onTap: () {},
                                    image: IconsAssets.copyOutline),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'copy_acc_id'.tr(),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontFamily: AppStrings.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.primary,
                          ),
                          GestureDetector(
                            onTap: () {
                              infoPopupController.dismissInfoPopup();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => RateDialog(
                                    profileImage: profileImage,
                                    profileName: profileName,
                                    userId: userId),
                              );
                            },
                            child: Row(
                              children: [
                                AppbarCircleButton(
                                    onTap: () {},
                                    image: IconsAssets.starOutline),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'rate'.tr(),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontFamily: AppStrings.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: AppColors.primary,
                          ),
                          GestureDetector(
                            onTap: () {
                              infoPopupController.dismissInfoPopup();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => ReportDialog(
                                  profileName: profileName,
                                  profileImage: profileImage,
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                AppbarCircleButton(
                                    onTap: () {},
                                    image: IconsAssets.reportOutline),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'report'.tr(),
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontFamily: AppStrings.fontFamily,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    arrowTheme: InfoPopupArrowTheme(
                      color: AppColors.primary,
                      arrowDirection: ArrowDirection.up,
                    ),
                    dismissTriggerBehavior:
                        PopupDismissTriggerBehavior.onTapArea,
                    areaBackgroundColor: Colors.transparent,
                    indicatorOffset: Offset.zero,
                    contentOffset: Offset.zero,
                    onControllerCreated: (controller) {
                      print('Info Popup Controller Created');
                      infoPopupController = controller;
                    },
                    onAreaPressed: (InfoPopupController controller) {
                      print('Area Pressed');
                      controller.dismissInfoPopup();
                    },
                    infoPopupDismissed: () {
                      print('Info Popup Dismissed');
                    },
                    onLayoutMounted: (Size size) {
                      print('Info Popup Layout Mounted');
                    },
                    child: Image.asset(
                      IconsAssets.dotsWhite,
                      width: 18,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          profileName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            fontFamily: AppStrings.fontFamily,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          ImagesAssets.verify,
                          width: 10,
                        )
                      ],
                    ),
                    Text(
                      profileInfo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppStrings.fontFamily,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(end: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$profileRate',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppStrings.fontFamily,
                        ),
                      ),
                      AnimatedRatingStars(
                        initialRating: profileRate,
                        minRating: 0.0,
                        maxRating: 5.0,
                        filledColor: Colors.amber,
                        emptyColor: Colors.grey,
                        filledIcon: Icons.star,
                        halfFilledIcon: Icons.star_half,
                        emptyIcon: Icons.star_border,
                        onChanged: (double rating) {
                          // Handle the rating change here
                          print('Rating: $rating');
                        },
                        // displayRatingValue: true,
                        interactiveTooltips: true,
                        customFilledIcon: Icons.star,
                        customHalfFilledIcon: Icons.star_half,
                        customEmptyIcon: Icons.star_border,
                        starSize: 1.0,
                        animationDuration: Duration(milliseconds: 300),
                        animationCurve: Curves.easeInOut,
                        readOnly: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
