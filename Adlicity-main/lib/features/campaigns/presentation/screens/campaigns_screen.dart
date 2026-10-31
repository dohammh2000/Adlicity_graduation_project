import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/ad_type_item.dart';
import 'package:adlicity/core/widgets/profile_mini_item.dart';
import 'package:adlicity/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:adlicity/features/campaigns/presentation/widgets/my_proposals_sections.dart';
import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheel_slider/wheel_slider.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/test.dart';
import '../../../../core/widgets/campaign_info_item.dart';
import '../widgets/my_campaigns_section.dart';
import '../widgets/offers_section.dart';

class CampaignsScreen extends StatefulWidget {
  const CampaignsScreen({super.key});

  @override
  State<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync:
            this); // Change the length according to the number of tabs you want
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CampaignCubit, CampaignState>(
        builder: (context, state) {
          return Column(
            children: [
              TabBar(
                indicatorColor: AppColors.primary,
                labelStyle: TextStyle(
                    color: AppColors.primary,
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.w600),
                controller: _tabController,
                tabs: [
                  Tab(text: 'offers'.tr()),
                  Tab(text: 'my_campaigns'.tr()),
                  Tab(text: 'proposals'.tr()),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Contents of Tab 1
                    OffersSection(),

                    // Contents of Tab 2
                    MyCampaignsSection(),

                    // Contents of Tab 3
                    MyProposalsSection(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}



// SizedBox(
//                                     width: context.width,
//                                   child: Image(
//                                     image: BlurhashTheImage(
//                                       AssetImage(
//                                         ImagesAssets.logo,
//                                       ), // you can use any image provider of your choice.
//                                     ),
//                                     alignment: Alignment.center,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
                                 
//                                     Container(
//                                       width: 100,
//                                       height: 20,
//                                       child: Image(
//                                         image: BlurhashTheImage(
//                                           AssetImage(
//                                             ImagesAssets.logo,
//                                           ), // you can use any image provider of your choice.
//                                         ),
//                                         alignment: Alignment.center,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ],
//                                 ),







//  RotatedBox(
//                                                   quarterTurns: 1,
//                                                   child: SizedBox(
//                                                     width: 200,
//                                                     height: 100,
//                                                     child: ListWheelScrollView(
                                                      
//                                                       itemExtent:
//                                                           20, // Adjust as needed
//                                                       diameterRatio:
//                                                           1, // Adjust as needed

//                                                       children: List.generate(
//                                                         10,
//                                                         (index) => ListTile(
//                                                           title: Center(
//                                                             child: RotatedBox(
//                                                               quarterTurns: -1,
//                                                               child: AdTypeItem(
//                                                                 adType: 'story',
//                                                                 profileImage:
//                                                                     ImagesAssets
//                                                                         .logo,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )