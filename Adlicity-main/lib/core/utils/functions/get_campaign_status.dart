import 'package:adlicity/config/themes/app_colors.dart';
import 'package:flutter/material.dart';

Color getCampaignStatusColor(String status) {
   switch (status.toLowerCase()) {
    case 'done':
      return const Color.fromARGB(255, 34, 255, 42);
    case 'rejected':
      return const Color.fromARGB(255, 255, 17, 0);
    case 'offering':
      return AppColors.secondary;
    case 'progress':
      return Colors.yellow;


    default:
      return AppColors.textColor;
  }

}