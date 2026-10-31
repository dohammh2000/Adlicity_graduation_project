import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import '../utils/constants.dart';
import '../utils/functions/get_campaign_status.dart';
import 'campaign_info_item.dart';

class CampaignItem extends StatelessWidget {
  final String status;
  final String dateFrom;
  final String dateTo;
  final String title;
  final String description;
  final String category;
  final Set<String> adTypes;
  final String price;
  final List<String> profileImages;
  final List<String> profileNames;
  final double? bottomLeft;
  final double? bottomRight;
  final double? topLeft;
  final double? topRight;
  final bool? isPadding;
  final Function()? onTap;
  CampaignItem({
    super.key,
    required this.status,
    required this.dateFrom,
    required this.dateTo,
    required this.title,
    required this.description,
    required this.category,
    required this.adTypes,
    required this.price,
    required this.profileImages,
    required this.profileNames,
    this.bottomLeft = 8,
    this.bottomRight = 8,
    this.topLeft = 8,
    this.topRight = 8,
    this.isPadding = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding!
          ? EdgeInsets.symmetric(horizontal: Constants.kPadding)
          : EdgeInsets.all(0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 300,
          width: context.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeft!),
              bottomRight: Radius.circular(bottomLeft!),
              topLeft: Radius.circular(topLeft!),
              topRight: Radius.circular(topRight!),
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(bottomLeft!),
              bottomRight: Radius.circular(bottomLeft!),
              topLeft: Radius.circular(topLeft!),
              topRight: Radius.circular(topRight!),
            ),
            child: Stack(
              children: [
                Image.asset(
                  ImagesAssets.campaignsItemBlurLogoBackground,
                  width: context.width,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  width: context.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 25,
                              width: context.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImagesAssets.blur,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'status'.tr(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: AppStrings.fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8),
                                  ),
                                  Text(
                                    status.tr(),
                                    style: TextStyle(
                                        color: getCampaignStatusColor(status),
                                        fontFamily: AppStrings.fontFamily,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 25,
                              width: context.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImagesAssets.blur,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Text(
                                '$dateFrom : $dateTo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: AppStrings.fontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 8),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          title,
                          style: TextStyle(
                            fontFamily: AppStrings.fontFamily,
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          description,
                          style: TextStyle(
                            fontFamily: AppStrings.fontFamily,
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                          ),
                          textAlign: TextAlign.justify,
                          maxLines: 8,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'publish_on'.tr(),
                                  style: TextStyle(
                                    fontFamily: AppStrings.fontFamily,
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                        ImagesAssets.blur,
                                      ),
                                      radius: 8,
                                      child: Image.asset(
                                        IconsAssets.facebook,
                                        width: 10,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CircleAvatar(
                                      backgroundImage: AssetImage(
                                        ImagesAssets.blur,
                                      ),
                                      radius: 8,
                                      child: Image.asset(
                                        IconsAssets.instagram,
                                        width: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              category.tr(),
                              style: TextStyle(
                                fontFamily: AppStrings.fontFamily,
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CampaignInfoItem(
                          adTypes: adTypes,
                          price: price,
                          profileImage: profileImages,
                          profileName: profileNames,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
