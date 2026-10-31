import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/features/home/presentation/widgets/title_and_subtitle_section.dart';
import 'package:adlicity/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:adlicity/features/wallet/presentation/widgets/deposit_section.dart';
import 'package:adlicity/features/wallet/presentation/widgets/withdraw_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/transaction_section.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync:
            this); // Change the length according to the number of tabs you want

    // Load the wallet amount when the screen is initialized
    context.read<WalletCubit>().loadWalletAmount();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        WalletCubit cubit = context.read<WalletCubit>();

        return Scaffold(
          body: Column(
            children: [
              TitleAndSubtitleSection(title: 'wallet', subtitle: 'you_have'),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 120,
                      width: context.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Constants.kRoundedCorner),
                        gradient: LinearGradient(
                          colors: [AppColors.secondary, AppColors.primary],
                        ),
                      ),
                      child: state is WalletLoaded
                          ? Text(
                              '${state.walletAmount} \$',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontFamily: AppStrings.fontFamily,
                                fontSize: 40,
                              ),
                            )
                          : state is WalletError
                              ? Text(
                                  'Error: ${state.error}',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: AppStrings.fontFamily,
                                    fontSize: 40,
                                  ),
                                )
                              : CircularProgressIndicator(),
                    ),
                    Image.asset(
                      ImagesAssets.logoWhiteRight,
                      width: 30,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Column(
                          children: [
                            SizedBox(height: 65),
                            Image.asset(
                              ImagesAssets.logoWhiteLeft,
                              width: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              TabBar(
                indicatorColor: AppColors.primary,
                labelStyle: TextStyle(
                  color: AppColors.primary,
                  fontFamily: AppStrings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  color: AppColors.textColor,
                  fontFamily: AppStrings.fontFamily,
                  fontWeight: FontWeight.w600,
                ),
                controller: _tabController,
                tabs: [
                  Tab(text: 'deposit'.tr()),
                  Tab(text: 'withdraw'.tr()),
                  Tab(text: 'transactions'.tr()),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // Contents of Tab 1
                    DepositSection(
                      selectedValue: cubit.depositPaymentMethod,
                      cubit: cubit,
                    ),
                    // Contents of Tab 2
                    WithdrawSection(
                      selectedValue: cubit.withdrawPaymentMethod,
                      cubit: cubit,
                    ),
                    // Contents of Tab 3
                    TransactionsSection(
                      cubit: cubit,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
