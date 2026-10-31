import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../utils/app_strings.dart';

class MyStepper extends StatelessWidget {
  const MyStepper({
    super.key,
    required this.cubit,
  });

  final cubit;

  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      activeStep: cubit.activeStep,

      activeStepTextColor: AppColors.primary,
      finishedStepTextColor: AppColors.primary,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 10,
      showStepBorder: false,

      lineStyle: LineStyle(
          lineType: LineType.normal,
          activeLineColor: AppColors.third,
          finishedLineColor: AppColors.primary,
          defaultLineColor: AppColors.third,
          lineLength: context.width / 3),

      // lineDotRadius: 1.5,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            radius: 10,
            backgroundColor: AppColors.third,
            child: CircleAvatar(
              radius: 10,
              backgroundColor:
                  cubit.activeStep > 0 ? AppColors.primary : AppColors.third,
              child: cubit.activeStep > 0
                  ? Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 14,
                    )
                  : Text(
                      '1',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: AppStrings.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
            ),
          ),
          title: 'info'.tr(),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 10,
            backgroundColor: AppColors.third,
            child: CircleAvatar(
              radius: 10,
              backgroundColor:
                  cubit.activeStep > 1 ? AppColors.primary : AppColors.third,
              child: cubit.activeStep > 1
                  ? Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 14,
                    )
                  : Text(
                      '2',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: AppStrings.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
            ),
          ),
          title: 'resources'.tr(),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 10,
            backgroundColor: AppColors.third,
            child: CircleAvatar(
              radius: 10,
              backgroundColor:
                  cubit.activeStep > 2 ? AppColors.primary : AppColors.third,
              child: cubit.activeStep > 2
                  ? Icon(
                      Icons.done,
                      color: Colors.white,
                      size: 14,
                    )
                  : Text(
                      '3',
                      style: TextStyle(
                          color: AppColors.primary,
                          fontFamily: AppStrings.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                    ),
            ),
          ),
          title: 'goal'.tr(),
        ),
      ],
      onStepReached: (index) {
        cubit.updateActiveStep(index);
      },
    );
  }
}
