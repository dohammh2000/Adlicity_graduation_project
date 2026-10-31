import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/main_button.dart';
import 'package:adlicity/features/otp/presentation/cubit/otp_cubit.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../widgets/otp_text_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OtpCubit, OtpState>(
        builder: (context, state) {
          OtpCubit cubit = BlocProvider.of(context);
          return SafeArea(
            child: Stack(
              children: [
                FullScreenBlurBackground(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: context.width * 0.55,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              Text(
                                'otp'.tr(),
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppStrings.fontFamily,
                                    fontSize: 50),
                              ),
                              Text(
                                'enter_otp_code'.tr(),
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppStrings.fontFamily,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Image.asset(
                            ImagesAssets.otpAva,
                            width: context.width * 0.65,
                          ),
                          SizedBox(height: 20),
                          OTPTextField(cubit: cubit,),
                          SizedBox(height: 20),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Constants.kPadding),
                            child:
                                MainButton(onPressed: () {     Navigator.pushReplacementNamed(context, Routes.homeRoute);}, title: 'submit'),
                          ),
                          TextButton(
                            onPressed: () {
                         
                            },
                            child: RichText(
                              text: TextSpan(
                                text: 'didnot_otp'.tr(),
                                style: TextStyle(
                                    fontFamily: AppStrings.fontFamily,
                                    fontSize: 12,
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'resend'.tr(),
                                    style: TextStyle(
                                        fontFamily: AppStrings.fontFamily,
                                        fontSize: 12,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.transparent),
                            ),
                          ),
                          SizedBox(height: 20,),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FullScreenBlurBackground extends StatelessWidget {
  const FullScreenBlurBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    ImagesAssets.logoRight,
                    height: context.height * 0.305,
                  ),
                ],
              ),
              SizedBox(
                height: context.height * 0.33,
              ),
              Row(
                children: [
                  Spacer(),
                  Image.asset(
                    ImagesAssets.logoLeft,
                    height: context.height * 0.305,
                  ),
                ],
              ),
            ],
          ),
        ),
        BlurryContainer(
          child: SizedBox(
            width: context.width,
            height: context.height,
          ),
          blur: 10,
          elevation: 0,
          color: Colors.transparent,
          padding: const EdgeInsets.all(0),
          borderRadius: const BorderRadius.all(Radius.circular(0)),
        ),
      ],
    );
  }
}
