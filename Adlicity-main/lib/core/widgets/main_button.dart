import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_strings.dart';

class MainButton extends StatelessWidget {
  final double? width;
  final Function() onPressed;
  final String title;
  final Color? titleColor;
  final List<Color>? backgroundColors;
  const MainButton({
    super.key,
    this.width,
    required this.onPressed,
    required this.title,
    this.titleColor = const Color(0xFFFFFFFF),
    this.backgroundColors = const [Color(0xFF60EFFF), Color(0xFF60A4FF)],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? context.width,
      height: 55,
      decoration: BoxDecoration(
        gradient:
            LinearGradient(colors: backgroundColors!),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title.toString().tr(),
          style: TextStyle(
              color: titleColor,
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
