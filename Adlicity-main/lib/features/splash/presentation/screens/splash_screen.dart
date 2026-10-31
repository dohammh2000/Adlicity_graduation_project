import 'dart:async';
import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    Timer(Duration(milliseconds: 2500), () {
      if (isLoggedIn) {
        // Navigate to the home screen if logged in
        Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
      } else {
        // Navigate to the login screen if not logged in
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [AppColors.secondary, AppColors.primary],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/logo_transparent_white.png',
            width: 120,
            height: 120,
          ),
        ),
      ),
    );
  }
}
