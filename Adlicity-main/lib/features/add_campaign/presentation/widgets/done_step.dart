
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/main_button.dart';
import '../cubit/add_campgain_cubit.dart';

class DoneStep extends StatelessWidget {
  const DoneStep({
    super.key,
    required this.cubit,
  });

  final AddCampgainCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cubit.activeStep == 3,
      child: Column(
        children: [
          Image.asset(
            ImagesAssets.doneAva,
            width: context.width * 0.7,
          ),
          SizedBox(
            height: 50,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: 'your_campaign_successfully_added'.tr(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                TextSpan(
                  text: 'under_review'.tr(),
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontFamily: AppStrings.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MainButton(
              onPressed: () {
                 cubit.resetForm();  // Reset the form fields and update the step
              },
              title: 'new_campaign')
        ],
      ).animate().fade(duration: Duration(milliseconds: 500)),
    );
  }
}