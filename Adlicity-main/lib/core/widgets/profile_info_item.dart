
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_strings.dart';

class ProfileInfoItem extends StatelessWidget {
  final String profileImage;
  final String profileName;
  final String profileInfo;
  final double profileRate;
  const ProfileInfoItem({
    super.key,
    required this.profileImage,
    required this.profileName,
    required this.profileInfo,
    required this.profileRate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 6, left: 6, right: 6),
      height: 33,
      width: 200,
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
              width: 200,
              height: 45,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Row(
              children: [
                SizedBox(
                  width: 3,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 14,
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppStrings.fontFamily,
                      ),
                    ),
                    Text(
                      profileInfo,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 6,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppStrings.fontFamily,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$profileRate',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
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
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
