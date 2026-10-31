
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';

class CategoryButton extends StatelessWidget {
  final Function() onTap;
  final String categoryName;
  final String selectedCategory;

  const CategoryButton({
    super.key,
    required this.onTap,
    required this.categoryName,
    required this.selectedCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 12,),
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment(0, 0),
            height: 22,
            width: 80,
            decoration: BoxDecoration(
              color: categoryName.toString().toLowerCase() ==
                      selectedCategory.toString().toLowerCase()
                  ? AppColors.primary
                  : AppColors.third,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              categoryName.toString().tr(),
              style: TextStyle(
                color: categoryName.toString().toLowerCase() ==
                        selectedCategory.toString().toLowerCase()
                    ? Colors.white
                    : AppColors.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
