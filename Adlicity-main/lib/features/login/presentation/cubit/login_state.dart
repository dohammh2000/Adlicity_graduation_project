part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginResetPasswordSuccess extends LoginState {
  final String successMessage;

  const LoginResetPasswordSuccess(this.successMessage);

  @override
  List<Object> get props => [successMessage];
}

class LoginInitial extends LoginState {
  //final User? user;

  //LoginInitial(this.user);

  //@override
  //List<Object> get props => [user!];
}

class LoginToggleShowPassword extends LoginState {
  final bool showPassword;

  LoginToggleShowPassword(this.showPassword);

  @override
  List<Object> get props => [showPassword];
}