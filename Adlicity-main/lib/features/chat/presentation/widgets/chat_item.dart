import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/constants.dart';

class ChatItem extends StatelessWidget {
  final Function() tileOnTap;
  final Function() profileOnTap;
  final String name;
  final String lastMessage;
  final String date;
  final String profileImage;

  const ChatItem({
    super.key,
    required this.tileOnTap,
    required this.profileOnTap,
    required this.name,
    required this.lastMessage,
    required this.date,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tileOnTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(Constants.kPadding),
          child: Row(
            children: [
              GestureDetector(
                onTap: profileOnTap,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 25,
                ),
              ),
              Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontFamily: AppStrings.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity, // Ensures the text does not overflow
                      child: Text(
                        lastMessage,
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontFamily: AppStrings.fontFamily,
                          fontWeight: FontWeight.w700,
                          fontSize: 8,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(12),
              Text(
                date,
                style: TextStyle(
                  color: AppColors.textColor,
                  fontFamily: AppStrings.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
