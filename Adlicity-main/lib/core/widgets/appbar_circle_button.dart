import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class AppbarCircleButton extends StatelessWidget {
  final VoidCallback onTap;
  final String image;


  const AppbarCircleButton({Key? key, required this.onTap, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: CircleAvatar(
          maxRadius: 17,
          backgroundColor: AppColors
              .third, // Assuming AppColors.third is defined in your app colors file
          child: Image.asset(
            image,
            width: 18,
          ),
        ),
      ),
    );
  }
}