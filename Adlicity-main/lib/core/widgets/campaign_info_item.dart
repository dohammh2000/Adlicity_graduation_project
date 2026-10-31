import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';
import 'ad_type_item.dart';
import 'profile_mini_item.dart';

class CampaignInfoItem extends StatelessWidget {
  final String price;
  final Set<String> adTypes;
  final List<String> profileImage;
  final List<String> profileName; 
 
  CampaignInfoItem(
      {super.key,
      required this.price,
      required this.adTypes,
      required this.profileImage,
      required this.profileName});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(ImagesAssets.blur),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: context.width * 0.16,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => AdTypeItem(
                  profileImage: ImagesAssets.logo,
                  adType: adTypes.toList()[index],
                  radius: 14,
                  fontSize: 8,
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
                itemCount: adTypes.length,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: VerticalDivider(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: context.width * 0.4,
              child: WheelSlider.customWidget(
                totalCount: profileName.length,
                initValue: 5,
                isInfinite: false,
                perspective: 0.0080,
                enableAnimation: false,


                scrollPhysics: const BouncingScrollPhysics(),
                children: List.generate(
                  profileName.length,
                  (index) => Center(
                    child: ProfileMiniItem(
                      profileImage: profileImage[index],
                      profileName: profileName[index],
                    ),
                  ),
                ),
                onValueChanged: (val) {
                  // setState(() {
                  //   // _cCurrentValue = val;
                  // });
                },
                hapticFeedbackType: HapticFeedbackType.lightImpact,
                showPointer: false,
                itemSize: 50,
                horizontal: true,
                isVibrate: true,
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: VerticalDivider(
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: context.width * 0.16,
              child: Text(
                '${price} \$',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: AppStrings.fontFamily,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
