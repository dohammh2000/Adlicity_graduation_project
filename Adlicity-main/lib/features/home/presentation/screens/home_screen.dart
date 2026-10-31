import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/main_button.dart';
import 'package:adlicity/features/home/presentation/cubit/home_cubit.dart';
import 'package:blurhash_ffi/blurhash_the_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/ad_type_item.dart';
import '../../../../core/widgets/category_button.dart';
import '../../../../core/widgets/platform_followers_item.dart';
import '../../../../core/widgets/profile_item.dart';
import '../../../../core/widgets/proposal_full_info_item.dart';
import '../../../../core/widgets/proposal_full_item.dart';
import '../../../../core/widgets/proposal_info_item.dart';
import '../widgets/announcements_slider.dart';
import '../widgets/title_and_subtitle_section.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<String?> _userNameFuture;
  late Future<List<Map<String, dynamic>>> _CampaignDataFuture;
  late Future<List<QueryDocumentSnapshot>> _topUsersFuture;

  @override
  void initState() {
    super.initState();
    HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    _userNameFuture = cubit.getCurrentUserName();
    _CampaignDataFuture = cubit.getCampaignsWithCreatorData();
    cubit.loadAppliedStates();
      _topUsersFuture = cubit.getTopUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          HomeCubit cubit = BlocProvider.of(context);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FutureBuilder<String?>(
                  future: _userNameFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final currentUserName = snapshot.data ?? 'Unknown User';
                      return TitleAndSubtitleSection(
                        subtitle: 'welcome_back',
                        title: 'hello',
                        title2: currentUserName,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                AnnouncementsSlider(),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 22,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => CategoryButton(
                      categoryName: Constants.categories[index],
                      onTap: () {
                        cubit.changeCategory(Constants.categories[index]);
                      },
                      selectedCategory: cubit.selectedCategory,
                    ),
                    itemCount: Constants.categories.length,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleAndSubtitleSection(
                        subtitle: 'influencers', title: 'trending'),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Colors.transparent; // No overlay color
                          },
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.trendingRoute);
                      },
                      child: Text(
                        'see_more'.tr(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: AppStrings.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                FutureBuilder<List<QueryDocumentSnapshot>>(
                  future: _topUsersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Text('No trending users available');
                    } else {
                      List<QueryDocumentSnapshot> users = snapshot.data!;
                      return SizedBox(
                        height: 220,
                        child: ListView.separated(
                          padding: EdgeInsetsDirectional.only(
                            start: Constants.kPadding,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => ProfileItem(
                            // Customize ProfileItem with user data
                            profileImage: users[index]['profileImage'],
                            profileInfo: users[index]['profileInfo'],
                            profileName: users[index]['profileName'], 
                            facebookFollowers: users[index]['facebookFollowers'],
                      instagramFollowers: users[index]['instagramFollowers'],
                      tiktokFollowers: users[index]['tiktokFollowers'],
                      twitterFollowers: users[index]['twitterFollowers'],
                      youTubeFollowers: users[index]['youTubeFollowers'],
                      profileRate: 4.6,
                          ),
                          itemCount: users.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(width: 15),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleAndSubtitleSection(
                        subtitle: 'campaigns', title: 'proposals'),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            return Colors.transparent; // No overlay color
                          },
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'see_more'.tr(),
                        style: TextStyle(
                            color: AppColors.textColor,
                            fontFamily: AppStrings.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: FutureBuilder<List<Map<String, dynamic>>>(
                    future: _CampaignDataFuture, // Fetch the campaign data
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Display a loading indicator while fetching data
                      } else if (snapshot.hasError) {
                        return Text(
                            'Error: ${snapshot.error}'); // Display an error message if data fetching fails
                      } else {
                        if (cubit.AccountType == 'Influencer') {
                          // If the current user is an influencer, display the campaign items
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Column(
                              children: [
                                ProposalFullItem(
                                  bottomLeftRadius: 0,
                                  bottomRightRadius: 0,
                                  topLeftRadius: 0,
                                  category: snapshot.data![index]
                                          ['campaignData']['category'] ??
                                      'Unknown',
                                  description: snapshot.data![index]
                                          ['campaignData']['Description'] ??
                                      'Unknown',
                                  facebookFollowers: snapshot.data![index]
                                              ['creatorData']
                                          ['facebookFollowers'] ??
                                      '0',
                                  instagramFollowers: snapshot.data![index]
                                              ['creatorData']
                                          ['instagramFollowers'] ??
                                      '0',
                                  price: snapshot.data![index]['campaignData']
                                          ['budget'] ??
                                      '.0',
                                  profileImage: snapshot.data![index]
                                          ['creatorData']['profileImage'] ??
                                      'Unknown Influencer',
                                  profileInfo: snapshot.data![index]
                                          ['creatorData']['profileInfo'] ??
                                      'Unknown Influencer',
                                  profileName: snapshot.data![index]
                                          ['creatorData']['FullName'] ??
                                      'Unknown Profile',
                                  profileRate: snapshot.data![index]
                                          ['creatorData']['profileRate'] ??
                                      0.0,
                                  tiktokFollowers: snapshot.data![index]
                                          ['creatorData']['tiktokFollowers'] ??
                                      '0',
                                  title: snapshot.data![index]['campaignData']
                                          ['Title'] ??
                                      'Untitled',
                                  twitterFollowers: snapshot.data![index]
                                          ['creatorData']['twitterFollowers'] ??
                                      '0',
                                  youTubeFollowers: snapshot.data![index]
                                          ['creatorData']['youTubeFollowers'] ??
                                      '0',
                                ),
                                // Add separation between items
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Constants.kPadding),
                                  child: GestureDetector(
                                    onTap: () {
                                      String campaignId = snapshot.data![index]
                                          ['campaignData']['campaignId'];
                                      cubit.applyToCampaign(campaignId);

                                      String snackBarMessage = cubit
                                                      .appliedStates[
                                                  snapshot.data![index]
                                                          ['campaignData']
                                                      ['campaign']] ==
                                              true
                                          ? 'You can apply to the campaign again'
                                          : 'You have successfully applied to the campaign';

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(snackBarMessage),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5),
                                      height: 40,
                                      width: context.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: BlurhashTheImage(
                                              NetworkImage(snapshot.data![index]
                                                      ['creatorData'][
                                                  'profileImage']), // you can use any image provider of your choice.
                                              decodingHeight:
                                                  context.height.toInt(),
                                              decodingWidth:
                                                  context.width.toInt()),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: AppStrings.fontFamily,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                          cubit.appliedStates[
                                                      snapshot.data![index]
                                                              ['campaignData']
                                                          ['campaignId']] ==
                                                  true
                                              ? 'Applied'
                                              : 'Apply',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 20),
                            itemCount: snapshot.data!.length,
                          );
                        } else {
                          return ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Column(
                              children: [
                                ProposalFullItem(
                                  bottomLeftRadius: 0,
                                  bottomRightRadius: 0,
                                  topLeftRadius: 0,
                                  category: snapshot.data![index]
                                          ['proposalData']['category'] ??
                                      'Unknown',
                                  description: snapshot.data![index]
                                          ['proposalData']['Description'] ??
                                      'Unknown',
                                  facebookFollowers: snapshot.data![index]
                                              ['creatorData']
                                          ['facebookFollowers'] ??
                                      '0',
                                  instagramFollowers: snapshot.data![index]
                                              ['creatorData']
                                          ['instagramFollowers'] ??
                                      '0',
                                  price: snapshot.data![index]['proposalData']
                                          ['price'] ??
                                      '.0',
                                  profileImage: snapshot.data![index]
                                          ['creatorData']['profileImage'] ??
                                      'Unknown Influencer',
                                  profileInfo: snapshot.data![index]
                                          ['creatorData']['profileInfo'] ??
                                      'Unknown Influencer',
                                  profileName: snapshot.data![index]
                                          ['creatorData']['profileName'] ??
                                      'Unknown Profile',
                                  profileRate: snapshot.data![index]
                                          ['creatorData']['profileRate'] ??
                                      0.0,
                                  tiktokFollowers: snapshot.data![index]
                                          ['creatorData']['tiktokFollowers'] ??
                                      '0',
                                  title: snapshot.data![index]['proposalData']
                                          ['Title'] ??
                                      'Untitled',
                                  twitterFollowers: snapshot.data![index]
                                          ['creatorData']['twitterFollowers'] ??
                                      '0',
                                  youTubeFollowers: snapshot.data![index]
                                          ['creatorData']['youTubeFollowers'] ??
                                      '0',
                                ),
                                // Add separation between items
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Constants.kPadding),
                                  child: GestureDetector(
                                    onTap: () {
                                      String proposalId = snapshot.data![index]
                                          ['proposalData']['proposalId'];
                                      cubit.applyToProposal(proposalId);

                                      String snackBarMessage = cubit
                                                      .appliedStates[
                                                  snapshot.data![index]
                                                          ['proposalData']
                                                      ['proposalId']] ==
                                              true
                                          ? 'You can apply to the proposal again'
                                          : 'You have successfully applied to the proposal';

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(snackBarMessage),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 5),
                                      height: 40,
                                      width: context.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(8),
                                            bottomRight: Radius.circular(8)),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: BlurhashTheImage(
                                              NetworkImage(snapshot.data![index]
                                                      ['creatorData'][
                                                  'profileImage']), // you can use any image provider of your choice.
                                              decodingHeight:
                                                  context.height.toInt(),
                                              decodingWidth:
                                                  context.width.toInt()),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: AppStrings.fontFamily,
                                              fontWeight: FontWeight.w700),
                                          textAlign: TextAlign.center,
                                          cubit.appliedStates[
                                                      snapshot.data![index]
                                                              ['proposalData']
                                                          ['proposalId']] ==
                                                  true
                                              ? 'Applied'
                                              : 'Apply',
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 20),
                            itemCount: snapshot.data!.length,
                          );
                        }
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
