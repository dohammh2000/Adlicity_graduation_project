import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:adlicity/features/main_layout/presentation/screens/main_screen.dart';
import 'package:adlicity/features/main_layout/presentation/screens/menu_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


class MainLayout extends StatelessWidget {
  final User? user;

  MainLayout({required this.user, Key? key}) : super(key: key);

  final ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainLayoutCubit(
        firebaseService: FirebaseService(),
        user: user,
      )..getUserData(user!.uid),
      child: BlocBuilder<MainLayoutCubit, MainLayoutState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: GestureDetector(
              onTap: () {
                if (zoomDrawerController.isOpen!()) {
                  zoomDrawerController.close!();
                }
              },
              child: ZoomDrawer(
                controller: zoomDrawerController,
                style: DrawerStyle.defaultStyle,
                menuScreen: MenuScreen(user : user),
                mainScreen: MainScreen(),
                borderRadius: 24.0,
                showShadow: true,
                angle: -12.0,
                drawerShadowsBackgroundColor: Colors.grey[300]!,
                slideWidth: MediaQuery.of(context).size.width * .65,
                openCurve: Curves.fastOutSlowIn,
                closeCurve: Curves.easeIn,
              ),
            ),
          );
        },
      ),
    );
  }
}