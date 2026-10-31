import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../utils/app_strings.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String? hintText;
  final Widget? prefixIcon;
  final bool isEmail;
  final bool isNumbers;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool obscureText;
  final bool isPassword;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextOverflow? overflow;
  final bool readOnly;
  final String? Function(String?)? validator;

  const InputField({
    super.key,
    required this.controller,
    this.suffixIcon,
    this.hintText,
    this.prefixIcon,
    this.isEmail = false,
    this.isNumbers = false,
    this.keyboardType,
    this.maxLines,
    this.obscureText = false,
    this.isPassword = false,
    this.overflow,
    this.onTap, this.onChanged,
    this.readOnly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      onTap: onTap,
      keyboardType: keyboardType,
      maxLines: maxLines,
      obscureText: obscureText,
      style: TextStyle(overflow: overflow),
      cursorColor: AppColors.primary,
      controller: controller,
      
      
      decoration: InputDecoration(
        
        
        isDense: true,

        hintText: hintText.toString().tr(),
        hintStyle: TextStyle(fontFamily: AppStrings.fontFamily),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.white,
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(125.0),
          borderSide: BorderSide(
            color: AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(125.0),
          borderSide: BorderSide(
            color: AppColors.textColor,
          ),
        ),
        // border: OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.red), // Change border color here

        //   borderRadius: BorderRadius.circular(150.0),
        // ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'required'.tr();
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value) &
            isEmail) {
          return 'valid_email'.tr();
        }
        if (!RegExp(r'^[0-9]+$').hasMatch(value) & isNumbers) {
          return 'numbers_only'.tr();
        }
        if ((value.length < 8) & this.isPassword) {
          return 'valid_password'.tr();
        }
        return null;
      },
      onChanged: onChanged,

    );
  }
}
