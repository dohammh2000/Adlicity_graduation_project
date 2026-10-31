
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';

class ButtonBlur extends StatelessWidget {
  final Function() onTap;
  final String title;
  const ButtonBlur({
    super.key,
    required this.onTap,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 155,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            image: DecorationImage(
                image: AssetImage(ImagesAssets.blur), fit: BoxFit.cover)),
        child: Text(
          title.tr(),
          style: TextStyle(
              color: Colors.white,
              fontFamily: AppStrings.fontFamily,
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
      ),
    );
  }
}
