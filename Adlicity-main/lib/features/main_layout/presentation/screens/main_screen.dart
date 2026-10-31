import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/widgets/appbar_circle_button.dart';
import '../cubit/main_layout_cubit.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MainLayoutCubit cubit = BlocProvider.of<MainLayoutCubit>(context);

    return Scaffold(
      appBar: _appbar(context, cubit),
      body: cubit.mainScreens[cubit.currentScreenIndex],
      bottomNavigationBar: _bottomNavigation(cubit),
    );
  }

  SnakeNavigationBar _bottomNavigation(MainLayoutCubit cubit) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.indicator,

      // shape: bottomBarShape,
      padding: EdgeInsets.symmetric(horizontal: 0),

      ///configuration for SnakeNavigationBar.color
      snakeViewColor: AppColors.primary,
      // selectedItemColor: snakeShape == SnakeShape.indicator ? selectedColor : null,
      // unselectedItemColor: Colors.white,
      backgroundColor: Colors.white,

      ///configuration for SnakeNavigationBar.gradient
      //snakeViewGradient: selectedGradient,
      //selectedItemGradient: snakeShape == SnakeShape.indicator ? selectedGradient : null,
      //unselectedItemGradient: unselectedGradient,

      // showUnselectedLabels: showUnselectedLabels,
      // showSelectedLabels: showSelectedLabels,

      currentIndex: cubit.currentScreenIndex,
      onTap: (index) {
        cubit.changeMainScreen(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: cubit.currentScreenIndex == 0
              ? Image.asset(
                  IconsAssets.homeFilled,
                  width: 20,
                )
              : Image.asset(
                  IconsAssets.homeOutline,
                  width: 20,
                ),
        ),
        BottomNavigationBarItem(
          icon: cubit.currentScreenIndex == 1
              ? Image.asset(
                  IconsAssets.campaignFilled,
                  width: 20,
                )
              : Image.asset(
                  IconsAssets.campaignOutline,
                  width: 20,
                ),
        ),
        BottomNavigationBarItem(
          icon: cubit.currentScreenIndex == 2
              ? Image.asset(
                  IconsAssets.addFilled,
                  width: 20,
                )
              : Image.asset(
                  IconsAssets.addOutline,
                  width: 20,
                ),
        ),
        BottomNavigationBarItem(
          icon: cubit.currentScreenIndex == 3
              ? Image.asset(
                  IconsAssets.walletFilled,
                  width: 20,
                )
              : Image.asset(
                  IconsAssets.walletOutline,
                  width: 20,
                ),
        ),
        BottomNavigationBarItem(
          icon: cubit.currentScreenIndex == 4
              ? Image.asset(
                  IconsAssets.profileFilled,
                  width: 20,
                )
              : Image.asset(
                  IconsAssets.profileOutline,
                  width: 20,
                ),
        ),
      ],
    );
  }

  AppBar _appbar(BuildContext context, MainLayoutCubit cubit) {
    return AppBar(
      leading: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () {
          ZoomDrawer.of(context)!.toggle();
        },
        icon: Image.asset(
          IconsAssets.drawer,
          width: 18,
        ),
      ),
      title: Text(
          cubit.mainScreensTitles[cubit.currentScreenIndex].toString().tr()),
      actions: [
        AppbarCircleButton(
          onTap: () {
            Navigator.pushNamed(context, Routes.searchRoute);
          },
          image: IconsAssets.search,
        ),
        // AppbarCircleButton(
        //   onTap: () {},
        //   image: IconsAssets.bellOutline,
        // ),
        AppbarCircleButton(
          onTap: () {
            Navigator.pushNamed(context, Routes.chatRoute);
          },
          image: IconsAssets.chat,
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
