import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../config/themes/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          SettingsCubit cubit = BlocProvider.of(context);
          return Padding(
            padding: EdgeInsets.all(Constants.kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'account_settings'.tr(),
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppStrings.fontFamily,
                    fontSize: 17,
                  ),
                ),
                Gap(10),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'push_notifications',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Switch.adaptive(
                    activeColor: Colors.white,
                    activeTrackColor: AppColors.primary,
                    applyCupertinoTheme: true,
                    inactiveThumbColor: AppColors.primary,
                    inactiveTrackColor: Colors.white,
                    trackOutlineColor:
                        MaterialStatePropertyAll(AppColors.primary),
                    value: cubit.pushNotifications,
                    onChanged: (value) {
                      cubit.togglePushNotification(value);
                    },
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'edit_profile'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Image.asset(
                    IconsAssets.arrowRight,
                    width: 20,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'change_password'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Image.asset(
                    IconsAssets.arrowRight,
                    width: 20,
                  ),
                ),
                Gap(10),
                Text(
                  'more'.tr(),
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w700,
                    fontFamily: AppStrings.fontFamily,
                    fontSize: 17,
                  ),
                ),
                Gap(10),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'about_us'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Image.asset(
                    IconsAssets.arrowRight,
                    width: 20,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'privacy_policy'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Image.asset(
                    IconsAssets.arrowRight,
                    width: 20,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'terms_conditions'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Image.asset(
                    IconsAssets.arrowRight,
                    width: 20,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'rate_us'.tr(),
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Image.asset(
                    IconsAssets.arrowRight,
                    width: 20,
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'delete_account'.tr(),
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                      fontFamily: AppStrings.fontFamily,
                      fontSize: 15,
                    ),
                  ),
                  trailing: Image.asset(
                    IconsAssets.arrowRight,
                    width: 20,
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: context.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'developed_by'.tr(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppStrings.fontFamily,
                          fontSize: 15,
                        ),
                      ),
                      Gap(5),
                      Text(
                        'Sherif Mahmoud',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: AppStrings.fontFamily,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset(
          IconsAssets.arrowLeft,
          width: 24,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'settings'.tr(),
        style: TextStyle(fontFamily: AppStrings.fontFamily, fontSize: 20),
      ),
      centerTitle: true,
    );
  }
}
