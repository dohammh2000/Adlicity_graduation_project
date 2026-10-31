import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/platform_followers_item.dart';
import 'package:adlicity/core/widgets/proposal_info_item.dart';
import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';

class ProposalFullInfoItem extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String profileImage;
  final String price;
    final String facebookFollowers;
  final String instagramFollowers;
  final String tiktokFollowers;
  final String twitterFollowers;
  final String youTubeFollowers;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double topLeftRadius;
  final double topRightRadius;
  const ProposalFullInfoItem({
    super.key,
    required this.title,
    required this.description,
    required this.category,
       this.bottomLeftRadius = 8,
    this.bottomRightRadius = 8,
    this.topLeftRadius = 8,
    this.topRightRadius = 8,
    required this.profileImage,
    required this.price, required this.facebookFollowers, required this.instagramFollowers, required this.tiktokFollowers, required this.twitterFollowers, required this.youTubeFollowers,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: context.width * 0.445,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
        ),
      ), 
      child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(bottomLeftRadius),
            bottomRight: Radius.circular(bottomRightRadius),
            topLeft: Radius.circular(topLeftRadius),
            topRight: Radius.circular(topRightRadius),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: BlurhashTheImage(
                

                  NetworkImage(
                      profileImage), // you can use any image provider of your choice.
                  decodingHeight: 1920,
                  decodingWidth: 1080),
             
              width: 200,
              height: 280,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8, top: 6),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: AppStrings.fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 8,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 14,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'publish_on'.tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppStrings.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Spacer()
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          PlatformFollowersItem(
                            platformLogo: IconsAssets.instagram,
                            followers: instagramFollowers,
                            profileImage: profileImage,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          PlatformFollowersItem(
                            platformLogo: IconsAssets.facebook,
                            followers:  facebookFollowers,
                            profileImage: profileImage,
                          ),
                          Spacer(),
                          Text(
                            category.toString().tr(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: AppStrings.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      ProposalInfoItem(
                        price: price,
                        profileImage: profileImage,
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
