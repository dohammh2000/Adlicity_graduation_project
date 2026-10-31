import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';
import '../utils/constants.dart';
import 'ad_type_item.dart';

class CampaignDetailsInfoItem extends StatelessWidget {
  final String price;
  final Set<String> adTypes;
  final String link;
  CampaignDetailsInfoItem({
    super.key,
    required this.price,
    required this.adTypes,
    required this.link,
  });

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
            Container(
              alignment: Alignment.center,
              width: context.width * 0.45,
              height: 35,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.kRoundedCorner)),
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(ImagesAssets.blur)),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 12),
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        link,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: AppStrings.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        IconsAssets.copyWhite,
                        width: 15,
                      ),
                    )
                  ],
                ),
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
