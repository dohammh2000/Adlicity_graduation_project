import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/profile_item.dart';
import '../cubit/profile_cubit.dart';
import 'profile_info_section.dart';
import 'profile_portfolio_section.dart';
import 'profile_statistics_section.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


// ignore: must_be_immutable
class ProfileBody extends StatefulWidget {
  ProfileBody(
      {super.key,
      required this.isScrolling,
      required this.scrollController,
      required this.tabController,
});

  bool isScrolling;
  TabController tabController;
  ScrollController scrollController;



 
   @override
  State<ProfileBody> createState() => _ProfileBodyState();
}
class _ProfileBodyState extends State<ProfileBody> {
    late ProfileCubit _profileCubit;
    User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
     _profileCubit = ProfileCubit(); // Initialize the _profileCubit

    // Fetch the profile data when the widget is initialized
    // _profileCubit.fetchDataById(user!.uid);
    _profileCubit.fetchDataById(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  void dispose() {
    // Dispose of the ProfileCubit when the widget is disposed
    _profileCubit.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
       bloc: _profileCubit,
   
      builder: (context, state) {
        if (state is ProfileLoading) {
          // Handle loading state
          return Center(child: CircularProgressIndicator());
        } else if (state is ProfileLoaded) {
          // Handle loaded state
          final profileData = state.profileData;

    return Column(
      children: [
        GestureDetector(
          onVerticalDragEnd: (details) {
            // Check the direction of the swipe
            if (details.velocity.pixelsPerSecond.dy > 0 && widget.isScrolling) {
              // Swipe Down
              print('Swiped Down');
              setState(() {
                widget.isScrolling = false;
              });
            }
          },
          child: ProfileItem(
            profileImage: profileData['profileImage'],
            width: context.width,
            height: widget.isScrolling
                ? context.height * 0.15
                : context.height * 0.45,
            tiktokFollowers: profileData['tiktokFollowers'],
            facebookFollowers:  profileData['facebookFollowers'],
            twitterFollowers: profileData['twitterFollowers'],
            youTubeFollowers: profileData['youTubeFollowers'],
            instagramFollowers:   profileData['instagramFollowers'],
            profileName: profileData['FullName'],
            profileInfo: profileData['AccountType'],
            profileRate: profileData['profileRate'],
            bottomLeftRadius: 0,
            bottomRightRadius: 0,
            topLeftRadius: 0,
            topRightRadius: 0,
            isMyProfile: true,
          ),
        ),
        TabBar(
          indicatorColor: AppColors.primary,
          labelStyle: TextStyle(
              color: AppColors.primary,
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.w600
              ),
          unselectedLabelStyle: TextStyle(
              color: AppColors.textColor,
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.w600),
          controller: widget.tabController,
          tabs: [
            Tab(text: 'info'.tr()),
            Tab(text: 'statistics'.tr()),
            Tab(text: 'portfolio'.tr()),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController,
            children: [
              // Contents of Tab 1
                            // Use the retrieved data in the ProfileInfoSection widget
              ProfileInfoSection(
                scrollController: widget.scrollController,
                profileData: profileData, // Pass the profileData to the widget
              ),

              // Contents of Tab 2
              ProfileStatisticsSection(
                  scrollController: widget.scrollController),

              // Contents of Tab 3
              ProfilePortfolioSection(
                scrollController: widget.scrollController,
                //  userId: user!.uid,
              ),
            ],
         ),
        ),
      ],
    );
        } else if (state is ProfileError) {
          // Handle error state
          return Text('Error: ${state.errorMessage}');
        } else {
          // Handle other states if needed
          return Container();
        }
      },
    );
  }
}
