import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/functions/get_ad_type_icon.dart';
import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdTypeItem extends StatelessWidget {
  final String profileImage;
  final String adType;
  final double?  radius;
  final double?  fontSize;
  const AdTypeItem({
    super.key,
    required this.profileImage,
    required this.adType,
    this.radius = 8,
    this.fontSize = 5
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:  2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: BlurhashTheImage(
                NetworkImage(
                    profileImage), // you can use any image provider of your choice.
                decodingHeight: 1920,
                decodingWidth: 1080),
            radius: radius,
            child: Image.asset(
              getAdTypeIcon(adType),
              width: radius! + 2,
            ),
          ),
          Text(
            adType.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              fontFamily: AppStrings.fontFamily,
            ),
          )
        ],
      ),
    );
  }
}
