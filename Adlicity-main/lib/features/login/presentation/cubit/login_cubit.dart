import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/features/home/presentation/cubit/home_cubit.dart';
import 'package:adlicity/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:adlicity/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/features/home/presentation/cubit/home_cubit.dart';
import 'package:adlicity/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:adlicity/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:bloc/bloc.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      // Display a success message or navigate to a success screen
    } catch (e) {
      print('Password reset failed: $e');
      throw e;
    }
  }

  Future<void> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;

      Navigator.of(context).pushReplacementNamed(Routes.homeRoute);

      //emit(LoginInitial(user));

      // Handle successful sign-in here
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Navigator.of(context).pushReplacementNamed(Routes.signUpRoute);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
      } else {
        print('Sign-in failed: ${e.message}');
        throw e;
      }
    } catch (e) {
      print('Sign-in failed: $e');
      throw e;
    }
  }
}

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  bool forgotPasswordClicked = false;
  void handleForgotPasswordClicked() {
    forgotPasswordClicked = true;
  }


  Future<void> sendPasswordResetEmail(String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  try {
    await auth.sendPasswordResetEmail(email: email);
    // Optionally, inform the user that the email has been sent
    print("Reset password email sent.");
  } catch (e) {
    // Handle errors, possibly by showing an alert to the user
    print("An error occurred while sending the reset email: $e");
  }
  }

  //final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Future<void> checkAuthenticationStatus() async {
  // final User? user = _firebaseAuth.currentUser;
  // emit(LoginInitial(user));
  //}

  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void toggleShowPassword(bool value) {
    showPassword = value;
    emit(LoginToggleShowPassword(showPassword));
  }

  void login(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      try {
        // Call the sign-in method from the FirebaseAuthService
        // await FirebaseAuthService(FirebaseAuth.instance)
        //   .signInWithEmailAndPassword(context, email, password);
        // Navigator.of(context).pushReplacementNamed(Routes.homeRoute);

        // Handle successful sign-in here, e.g., navigate to the home screen

        if (forgotPasswordClicked) {
          // Call the reset password method from the FirebaseAuthService
          await FirebaseAuthService(FirebaseAuth.instance)
              .resetPassword(context, email);

          emit(LoginResetPasswordSuccess(
              'Password reset instructions sent to your email.'));
        } else {
          // Call the sign-in method from the FirebaseAuthService
          await FirebaseAuthService(FirebaseAuth.instance)
              .signInWithEmailAndPassword(context, email, password);

          // Handle successful sign-in here, e.g., navigate to the home screen
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        }

        // Handle sign-in failure here, e.g., display an error message
      }
    }
    forgotPasswordClicked = false;
  }
}