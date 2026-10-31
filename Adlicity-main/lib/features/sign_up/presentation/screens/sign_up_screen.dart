import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/input_field.dart';
import 'package:adlicity/core/widgets/main_button.dart';
import 'package:adlicity/features/otp/presentation/screens/otp_screen.dart';
import 'package:adlicity/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        SignUpCubit cubit = BlocProvider.of(context);
        return SafeArea(
          child: Stack(
            children: [
              FullScreenBlurBackground(),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
                  child: Form(
                    key: cubit.signUpFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: context.width * 0.42,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Text(
                                  'sign_up'.tr(),
                                  style: TextStyle(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: AppStrings.fontFamily,
                                      fontSize: 50),
                                ),
                                Text(
                                  'sign_up_continue'.tr(),
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
                        SizedBox(height: 40),
                        InputField(
                          controller: cubit.fullNameController,
                          hintText: 'full_name',
                          maxLines: 1,
                          keyboardType: TextInputType.name,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              IconsAssets.profileFilled,
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        InputField(
                          controller: cubit.usernameController,
                          hintText: 'username',
                          maxLines: 1,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              IconsAssets.at,
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        InputField(
                          controller: cubit.emailController,
                          hintText: 'email',
                          keyboardType: TextInputType.emailAddress,
                          maxLines: 1,
                          isEmail: true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              IconsAssets.email,
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        InputField(
                          controller: cubit.passwordController,
                          hintText: 'password',
                          maxLines: 1,
                          obscureText: cubit.showPassword ? false : true,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              IconsAssets.lock,
                              width: 1,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              cubit.toggleShowPassword(!cubit.showPassword);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Image.asset(
                                cubit.showPassword
                                    ? IconsAssets.eyeCrossed
                                    : IconsAssets.eye,
                                width: 1,
                              ),
                            ),
                          ),
                          isPassword: true,
                        ),
                        SizedBox(height: 15),
                        InputField(
                          controller: cubit.dateOfBirthController,
                          hintText: 'date_of_birth',
                          maxLines: 1,
                          keyboardType: TextInputType.datetime,
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Image.asset(
                              IconsAssets.calendarFilled,
                              width: 1,
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(
                                      color: AppColors.textColor, width: 1)),
                              child: CountryCodePicker(
                                onChanged: (CountryCode code) {
                                  print(
                                      '=====================================');
                                  print(code);
                                  print(
                                      '=====================================');
                                },
                                initialSelection: 'EG',
                                favorite: ['+20'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                alignLeft: false,
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.55,
                              child: InputField(
                                controller: cubit.phoneNumberController,
                                hintText: 'phone_number',
                                maxLines: 1,
                                keyboardType: TextInputType.phone,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Transform.flip(
                                    flipX: true,
                                    child: Image.asset(
                                      IconsAssets.phoneFilled,
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Text(
                          'acc_type'.tr(),
                          style: TextStyle(
                              color: AppColors.primary,
                              fontFamily: AppStrings.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: context.width * 0.4,
                              child: RadioListTile.adaptive(
                                activeColor: AppColors.primary,
                                selected: true,
                                title: Text('influencer'.tr(),
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontFamily: AppStrings.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    )),
                                value: AppStrings.influencer,
                                groupValue: cubit.accountType,
                                onChanged: (value) {
                                  cubit.changeAccountType(value!);
                                },
                              ),
                            ),
                            SizedBox(
                              width: context.width * 0.4,
                              child: RadioListTile.adaptive(
                                activeColor: AppColors.primary,
                                title: Text('advertiser'.tr(),
                                    style: TextStyle(
                                      color: AppColors.textColor,
                                      fontFamily: AppStrings.fontFamily,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                    )),
                                value: AppStrings.advertiser,
                                groupValue: cubit.accountType,
                                onChanged: (value) {
                                  cubit.changeAccountType(value!);
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainButton(
                                onPressed: () {
                                  cubit.signUp(context);
                                  //cubit.addUser();
                                },
                                title: 'sign_up'),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.loginRoute);
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: 'have_acc'.tr(),
                                  style: TextStyle(
                                      fontFamily: AppStrings.fontFamily,
                                      fontSize: 12,
                                      color: AppColors.textColor,
                                      fontWeight: FontWeight.w600),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'login'.tr(),
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
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
