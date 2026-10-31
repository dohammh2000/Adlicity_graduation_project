import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/main_button.dart';
import '../cubit/wallet_cubit.dart';

// ignore: must_be_immutable
class DepositSection extends StatefulWidget {
  String? selectedValue;
  final WalletCubit cubit;

  DepositSection({super.key, required this.selectedValue, required this.cubit});

  @override
  State<DepositSection> createState() => _DepositSectionState();
}

class _DepositSectionState extends State<DepositSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Image.asset(
              ImagesAssets.creditAva,
              width: context.width * 0.6,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
              child: Container(
                width: context.width,
                height: 55,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(150),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: Image.asset(
                      IconsAssets.arrowDown,
                      width: 18,
                    ),
                    value: widget.selectedValue,
                    hint: Text('payment_method'.tr()),
                    onChanged: (newValue) {
                      setState(() {
                        widget.selectedValue = newValue!;
                        widget.cubit.depositPaymentMethod = newValue;
                      });
                    },
                    items: <String>[
                      'Paypal',
                      'Credit Card',
                      'Wire Transfer',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    style: TextStyle(
                      fontFamily: AppStrings.fontFamily,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  Container(
                    width: context.width,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColors.third,
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: TextField(
                      controller: widget.cubit.depositAmountController,
                      cursorColor: AppColors.primary,
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: AppStrings.fontFamily,
                        fontWeight: FontWeight.w700,
                      ),
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      decoration: InputDecoration(
                        icon: Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 25, top: 5),
                          child: Text(
                            '\$',
                            style: TextStyle(
                                fontFamily: AppStrings.fontFamily,
                                color: AppColors.textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 0.0,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  MainButton(
                    onPressed: () {
                      widget.cubit.deposit();
                    },
                    title: 'deposit',
                    width: context.width * 0.35,
                  ),
                ],
              ),
            ),
            BlocBuilder<WalletCubit, WalletState>(
              builder: (context, state) {
                if (state is WalletError) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Error: ${state.error}',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
