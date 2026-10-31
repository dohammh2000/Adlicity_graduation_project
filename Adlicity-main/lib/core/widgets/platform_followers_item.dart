import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_strings.dart';

class PlatformFollowersItem extends StatelessWidget {
  final String platformLogo;
  final String followers;
  final String profileImage;
  final bool? isMyProfile;

  const PlatformFollowersItem({
    super.key,
    required this.platformLogo,
    required this.followers,
    required this.profileImage,
    this.isMyProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Stack(
          alignment: Alignment(0, 0),
          children: [
            Image(
              image: BlurhashTheImage(
                  NetworkImage(
                      profileImage), // you can use any image provider of your choice.
                  decodingHeight: 1920,
                  decodingWidth: 1080),
              width: isMyProfile! ? 60 : 30,
              height: isMyProfile! ? 25 : 15,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  platformLogo,
                  width: isMyProfile! ? 13 : 7,
                ),
                SizedBox(
                  width: isMyProfile! ? 5 : 2,
                ),
                Text(
                  followers,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMyProfile! ? 9 :6,
                    fontFamily: AppStrings.fontFamily,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
