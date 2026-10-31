import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/core/widgets/platform_followers_item.dart';
import 'package:adlicity/core/widgets/profile_info_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/assets_manager.dart';
import 'my_profile_item.dart';

class ProfileItem extends StatelessWidget {
  final String profileImage; 
  final String tiktokFollowers;
  final String facebookFollowers;
  final String twitterFollowers;
  final String youTubeFollowers;
  final String instagramFollowers;
  final String profileName;
  final String profileInfo;
  final double profileRate;
  final double width;
  final double height;
  final double bottomLeftRadius; 
  final double bottomRightRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final bool? isMyProfile;
   final String? userId;

  const ProfileItem({
    super.key,
    required this.profileImage,
    required this.tiktokFollowers,
    required this.facebookFollowers,
    required this.twitterFollowers,
    required this.youTubeFollowers,
    required this.instagramFollowers,
    required this.profileName,
    required this.profileInfo,
    required this.profileRate,
    this.width = 180,
    this.height = 220,
    this.bottomLeftRadius = 8,
    this.bottomRightRadius = 8,
    this.topLeftRadius = 8,
    this.topRightRadius = 8,
    this.isMyProfile = false,
       this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isMyProfile!) {
          Navigator.pushNamed( 
            context,
            Routes.profileDetailsRoute,
            arguments: { 
              'profileImage': profileImage,
              'tiktokFollowers': tiktokFollowers,
              'facebookFollowers': facebookFollowers,
              'twitterFollowers': twitterFollowers,
              'youTubeFollowers': youTubeFollowers,
              'instagramFollowers': instagramFollowers,
              'profileName': profileName,
              'profileInfo': profileInfo,
              'profileRate': profileRate,
         
            },
          );
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                profileImage,
              ),
              fit: BoxFit.cover),
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
          child: Column(
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PlatformFollowersItem(
                    platformLogo: IconsAssets.tiktok,
                    followers: tiktokFollowers,
                    profileImage: profileImage,
                    isMyProfile: isMyProfile,
                  ),
                  PlatformFollowersItem(
                    platformLogo: IconsAssets.instagram,
                    followers: instagramFollowers,
                    profileImage: profileImage,
                    isMyProfile: isMyProfile,
                  ),
                  PlatformFollowersItem(
                    platformLogo: IconsAssets.youtube,
                    followers: youTubeFollowers,
                    profileImage: profileImage,
                    isMyProfile: isMyProfile,
                  ),
                  PlatformFollowersItem(
                    platformLogo: IconsAssets.facebook,
                    followers: facebookFollowers,
                    profileImage: profileImage,
                    isMyProfile: isMyProfile,
                  ),
                  PlatformFollowersItem(
                    platformLogo: IconsAssets.twitter,
                    followers: twitterFollowers,
                    profileImage: profileImage,
                    isMyProfile: isMyProfile,
                  ),
                ],
              ),
              Spacer(),
              isMyProfile!
                  ? MyProfileInfoItem(
                      profileImage: profileImage,
                      profileName: profileName,
                      profileInfo: profileInfo,
                      profileRate: profileRate,
                      userId: userId ?? '',
                    )
                  : ProfileInfoItem(
                      profileImage: profileImage,
                      profileInfo: profileInfo,
                      profileName: profileName,
                      profileRate: profileRate,
                    ),
              SizedBox(
                height: isMyProfile! ? 6 : 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}