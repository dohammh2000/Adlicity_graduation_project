import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/widgets/profile_item.dart';
import 'package:adlicity/features/trending/presentation/cubit/trending_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/category_button.dart';

// ignore: must_be_immutable
class TrendingScreen extends StatelessWidget {
  TrendingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Trending'),
      ),
      body: BlocProvider(
        create: (context) => TrendingCubit()..getTopUsers(), // Initialize and fetch top users
        child: BlocBuilder<TrendingCubit, TrendingState>(
          builder: (context, state) {
            if (state is TrendingLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is TrendingLoaded) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    SizedBox(
                      height: 22,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => CategoryButton(
                          categoryName: context.read<TrendingCubit>().categories[index],
                          onTap: () {
                            context.read<TrendingCubit>().changeCategory(
                              context.read<TrendingCubit>().categories[index],
                            );
                          },
                          selectedCategory: context.read<TrendingCubit>().selectedCategory,
                        ),
                        itemCount: context.read<TrendingCubit>().categories.length,
                      ),
                    ),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.profiles.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),
                      itemBuilder: (context, index) {
                        final profile = state.profiles[index];
                        // Replace ProfileItem with your widget that displays profile information
                        return ProfileItem(
                          // Assuming ProfileItem constructor parameters based on your usage
                          profileImage: profile['profileImage'],
                          profileInfo: profile['profileInfo'],
                          profileName: profile['profileName'],
                          profileRate: profile['profileRate'],
                          facebookFollowers: profile['facebookFollowers'],
                          instagramFollowers: profile['instagramFollowers'],
                          tiktokFollowers: profile['tiktokFollowers'],
                          twitterFollowers: profile['twitterFollowers'],
                          youTubeFollowers: profile['youTubeFollowers'],
                        );
                      },
                      padding: EdgeInsets.all(Constants.kPadding),
                    ),
                  ],
                ),
              );
            } else if (state is TrendingError) {
              return Center(child: Text(state.message));
            } else {
              return Container(); // Handle other states if necessary
            }
          },
        ),
      ),
    );
  }
}



