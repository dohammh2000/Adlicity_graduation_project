import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_strings.dart';

class DrawerButtonCustom extends StatelessWidget {
  final String icon;
  final String text;
  final Function() onTap;
  const DrawerButtonCustom({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 18,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              text.toString().tr(),
              style: TextStyle(
                color: Colors.white,
                fontFamily: AppStrings.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
