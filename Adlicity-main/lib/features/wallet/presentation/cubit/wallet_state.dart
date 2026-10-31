// part of 'wallet_cubit.dart';

// abstract class WalletState extends Equatable {
//   const WalletState();

//   @override
//   List<Object> get props => [];
// }

// class WalletInitial extends WalletState {}

// class WalletLoading extends WalletState {}

// class WalletLoaded extends WalletState {
//   final double walletAmount;
//   final List<Map<String, dynamic>> transactions;

//   const WalletLoaded({required this.walletAmount, required this.transactions});

//   @override
//   List<Object?> get props => [walletAmount, transactions];
// }

// class WalletError extends WalletState {
//   final String error;

//   const WalletError( this.error);

//   @override
//   List<Object> get props => [error];
// }
part of 'wallet_cubit.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final double walletAmount;
  final List<Map<String, dynamic>> transactions;

  const WalletLoaded({required this.walletAmount, required this.transactions});

  @override
  List<Object?> get props => [walletAmount, transactions];
}

class WalletError extends WalletState {
  final String error;

  const WalletError(this.error);

  @override
  List<Object?> get props => [error];
}

