
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/features/add_proposal/presentation/cubit/add_proposal_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/category_button.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';

class InfoStepProposal extends StatelessWidget {
  const InfoStepProposal({
    super.key,
    required this.cubit,
  });

  final AddProposalCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cubit.activeStep == 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            ImagesAssets.infoProp,
            width: context.width * 0.7,
          ),
          InputField(
            controller: cubit.title,
            hintText: 'title',
            maxLines: 1,
            prefixIcon: Icon(
              Icons.title,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InputField(
            controller: cubit.description,
            hintText: 'description',
            maxLines: 1,
            prefixIcon: Icon(
              Icons.description,
              color: AppColors.primary,
            ),
          ),
        
          SizedBox(
            height: 20,
          ),
          InputField(
            controller: cubit.duration,
            hintText: 'duration',
            maxLines: 1,
            prefixIcon: Icon(
              Icons.date_range,
              color: AppColors.primary,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'category'.tr(),
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 12,
                fontFamily: AppStrings.fontFamily,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 22,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CategoryButton(
                categoryName: Constants.categories[index],
                onTap: () {
                  cubit.changeCategory(Constants.categories[index]);
                },
                selectedCategory: cubit.selectedCategory,
              ),
              itemCount: Constants.categories.length,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MainButton(onPressed: () {
            cubit.updateActiveStep(1);
          }, title: 'next'),
          SizedBox(
            height: 40,
          ),
        ],
      ).animate().fade(duration: Duration(milliseconds: 500)),
    );
  }
}

