part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpChangeAccountType extends SignUpState {
  final String accountType;

  SignUpChangeAccountType({required this.accountType});
  @override
  List<Object> get props => [accountType];
}

class SignUpToggleShowPassword extends SignUpState {
  final bool showPassword;

  SignUpToggleShowPassword(this.showPassword);

  @override
  List<Object> get props => [showPassword];
}
