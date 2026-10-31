// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:adlicity/features/otp/presentation/cubit/otp_cubit.dart';

import '../../../../config/themes/app_colors.dart';

class OTPTextField extends StatelessWidget {
  final OtpCubit cubit;
  const OTPTextField({
    Key? key,
    required this.cubit,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        cubit.fieldsCount,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          width: 60.0,
          height: 60.0,
          child: TextFormField(
            controller: cubit.controllers[index],
            focusNode: cubit.focusNodes[index],
            maxLength: 1,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < cubit.fieldsCount - 1) {
                  cubit.focusNodes[index].unfocus();
                  FocusScope.of(context)
                      .requestFocus(cubit.focusNodes[index + 1]);
                } else {
                  cubit.focusNodes[index].unfocus();
                  // You can trigger OTP verification here
                  print(cubit.controllers[index].text);
                  print('-----------------------------');
                }
              }
            },
            decoration: InputDecoration(
              counter: Offstage(),
              contentPadding: EdgeInsets.zero,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: AppColors.textColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: AppColors.primary),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
