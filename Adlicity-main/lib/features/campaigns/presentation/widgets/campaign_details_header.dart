
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/functions/get_campaign_status.dart';
import '../../../../core/widgets/campaign_details_info_item.dart';

class CampaignDetailsHeader extends StatelessWidget {
  final String status;
  final String date;
  final String title;
  final String description;
  final String category;
  final Set<String> adTypes;
  final String price;
  final String link;
  const CampaignDetailsHeader({
    super.key,
    required this.status,
    required this.date,
    required this.title,
    required this.description,
    required this.category,
    required this.adTypes,
    required this.price,
    required this.link,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: context.height * 0.6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            ImagesAssets.campaignsItemBlurLogoBackground,
          ),
          //  width: context.width,
          fit: BoxFit.cover,
        ),
      ),
      width: context.width,
      child: Column(
        // fit: StackFit.expand,
        children: [
          SizedBox(
            width: context.width,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: context.width * 0.08),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(150),
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImagesAssets.blur,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Image.asset(
                                IconsAssets.arrowLeftWhite,
                                width: 12,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
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
                                      fontSize: 10),
                                ),
                                Text(
                                  status.tr(),
                                  style: TextStyle(
                                      color: getCampaignStatusColor(status),
                                      fontFamily: AppStrings.fontFamily,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 25,
                          width: context.width * 0.15,
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
                            '25/9/2023',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: AppStrings.fontFamily,
                                fontWeight: FontWeight.w500,
                                fontSize: 8),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: AppStrings.fontFamily,
                        color: Colors.white,
                        fontSize: 24,
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
                      ),
                      textAlign: TextAlign.justify,
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
                                fontSize: 10,
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
                                  radius: 10,
                                  child: Image.asset(
                                    IconsAssets.facebook,
                                    width: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                    ImagesAssets.blur,
                                  ),
                                  radius: 10,
                                  child: Image.asset(
                                    IconsAssets.instagram,
                                    width: 12,
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
                      height: 15,
                    ),
                    CampaignDetailsInfoItem(
                      adTypes: adTypes,
                      price: price,
                      link: link,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
