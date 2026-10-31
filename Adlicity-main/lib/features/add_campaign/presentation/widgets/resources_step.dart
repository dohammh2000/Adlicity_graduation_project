
import 'dart:io';

import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../../core/widgets/main_button.dart';
import '../cubit/add_campgain_cubit.dart';
import 'package:adlicity/features/add_campaign/presentation/widgets/image_upload_field.dart';

class ResourcesStep extends StatelessWidget {
  const ResourcesStep({
    super.key,
    required this.cubit,
    required this.imageFile,
    required this.onImageSelected,
  });

  final AddCampgainCubit cubit;
  final File? imageFile;
  final Function(File? imageFile) onImageSelected;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: cubit.activeStep == 1,
      child: Form(
        key: cubit.resourcesFormKey,
        child: Column(
          children: [
            Image.asset(
              ImagesAssets.resAva,
              width: context.width * 0.7,
            ),
            InputField(
              controller: cubit.link,
              hintText: 'link',
              maxLines: 1,
              prefixIcon: Icon(
                Icons.link,
                color: AppColors.primary,
              ),
              validator: (value) => cubit.validateResourcesForm(),
            ),
            SizedBox(
              height: 20,
            ),
            ImageUploadField(onImageSelected: onImageSelected),
            SizedBox(
              height: 20,
            ),
            InputField(
              controller: cubit.notes,
              hintText: 'notes',
              maxLines: 1,
              prefixIcon: Icon(
                Icons.note,
                color: AppColors.primary,
              ),
              validator: (value) => cubit.validateResourcesForm(),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'ad_type'.tr(),
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
              height: 180,
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                physics: NeverScrollableScrollPhysics(),
                itemCount: Constants.adTypes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  crossAxisSpacing: 50,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final adType = Constants.adTypes[index];
                  final isChecked = cubit.chosenAdTypes.containsKey(adType)
                      ? cubit.chosenAdTypes[adType]
                      : false;
                  return CheckboxListTile.adaptive(
                    contentPadding: EdgeInsets.all(0),
                    value: isChecked,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(
                      adType.tr(),
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: AppStrings.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    activeColor: AppColors.primary,
                    side: BorderSide(color: AppColors.primary),
                    onChanged: (bool? value) {
                      cubit.toggleAdType(
                        index: index,
                        value: value ?? false,
                      );
                      print(cubit.chosenAdTypes[Constants.adTypes[index]]);
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainButton(
                  width: context.width / 2.4,
                  backgroundColors: [AppColors.third, AppColors.third],
                  titleColor: AppColors.primary,
                  onPressed: () {
                    cubit.updateActiveStep(cubit.activeStep - 1);
                  },
                  title: 'back',
                ),
                MainButton(
                  width: context.width / 2.4,
                  onPressed: () {
                    if (cubit.resourcesFormKey.currentState!.validate()) {
                      cubit.updateActiveStep(cubit.activeStep + 1);
                    }
                  },
                  title: 'next',
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ).animate().fade(duration: Duration(milliseconds: 500)),
      ),
    );
  }
}
