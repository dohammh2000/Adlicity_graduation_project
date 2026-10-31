

import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/ad_type_item.dart';
import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/app_strings.dart';

class ProposalInfoItem extends StatelessWidget {
  final String price;
  final String profileImage;
  const ProposalInfoItem({
    super.key, required this.price, required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 6,
      ),
      height: 33,
      width: context.width * 0.5,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(50),
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(50),
        child: Stack(
          children: [
            Image(
              image: BlurhashTheImage(
                  NetworkImage(profileImage), // you can use any image provider of your choice.
                  decodingHeight: 1920,
                  decodingWidth: 1080),
              width: context.width * 0.44,
              height: 33,
              alignment: Alignment.center,
              fit: BoxFit.cover,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5,
                ),
                AdTypeItem(
                    adType: 'inVideo',
                    profileImage:
                        profileImage),
                AdTypeItem(
                    adType: 'story',
                    profileImage:
                      profileImage),
                AdTypeItem(
                    adType: 'fullVideo',
                    profileImage:
                        profileImage),
                AdTypeItem(
                    adType: 'post',
                    profileImage:
                        profileImage),
                AdTypeItem(
                    adType: 'reel',
                    profileImage:
                        profileImage),
                Spacer(),
                Text(
                  '$price\$',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize:10,
                    fontWeight:
                        FontWeight.w600,
                    fontFamily: AppStrings
                        .fontFamily,
                  ),
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
