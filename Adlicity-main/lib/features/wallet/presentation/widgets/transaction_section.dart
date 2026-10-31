import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionsSection extends StatelessWidget {
  final WalletCubit cubit;

  TransactionsSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return CircularProgressIndicator();
            } else if (state is WalletLoaded) {
              return ListView.separated(
                itemBuilder: (context, index) {
                  final transaction = state.transactions[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: AppColors.primary,
                        child: transaction['title'] == 'Deposit'
                            ? Image.asset(
                                IconsAssets.transUp,
                                width: 30,
                              )
                            : Image.asset(
                                IconsAssets.transDown,
                                width: 30,
                              ),
                      ),
                      title: Text(
                        transaction['title'] ?? 'Unknown',
                      ),
                      titleTextStyle: TextStyle(
                        color: AppColors.primary,
                        fontFamily: AppStrings.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                      subtitle: Text(transaction['subtitle'] ?? 'No subtitle'),
                      subtitleTextStyle: TextStyle(
                        color: AppColors.textColor,
                        fontFamily: AppStrings.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${transaction['amount']} \$',
                            style: TextStyle(
                              color: transaction['title'] == 'Deposit'
                                  ? Colors.green
                                  : Colors.red,
                              fontFamily: AppStrings.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            (transaction['date'] as Timestamp).toDate().toString(),
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontFamily: AppStrings.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    Divider(color: AppColors.primary),
                itemCount: state.transactions.length,
              );
            } else if (state is WalletError) {
              return Text(state.error);
            } else {
              return Text('No transactions available');
            }
          },
        ),
      ),
    );
  }
}
